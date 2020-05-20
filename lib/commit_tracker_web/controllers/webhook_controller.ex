defmodule CommitTrackerWeb.WebhookController do
  use CommitTrackerWeb, :controller
  alias CommitTracker.Tracker.{Repository, Author, Commit}
  alias CommitTracker.Repo
  alias CommitTracker.Tracker

  # Push action payload pattern matching
  def actions(
        conn,
        %{
          "commits" => commits,
          "repository" => repository,
          "pushed_at" => pushed_at,
          "pusher" => pusher
        }
      ) do
    # Creating an author push
    push_author = find_or_create_author(pusher)

    repo = find_or_create_repository(repository)
    commit_status = "ready for release"

    repo
    |> create_push_with_push_author_repository(pushed_at, push_author)
    |> create_commits_with_push_repo_author(repo, commits, commit_status)
    |> post_commits_to_ticket_tracker()

    # TODO: Need to send the request to the ticket tracking system
    json(conn, %{ok: "success"})
  end

  # Release action payload pattern matching
  def actions(conn, %{
        "action" => action,
        "released_at" => released_at,
        "release" => release,
        "repository" => repository
      }) do
    # Release action
    repo = find_or_create_repository(repository)
    created_release = find_or_create_release_with_author(release, released_at, repo, action)
    commit_status = "released"

    create_or_find_commits(repo, release["commits"], commit_status)
    |> associate_commits_to_release(created_release)
    |> post_commits_to_ticket_tracker()

    # TODO: Need to send request to ticket tracking system
    json(conn, %{ok: "success"})
  end

  # Pullrequest action payload pattern matching
  def actions(conn, %{
        "action" => action,
        "number" => number,
        "pull_request" => pull_request,
        "repository" => repository
      }) do
    repo = find_or_create_repository(repository)

    created_pr =
      repo
      |> find_or_create_pull_request_with_author(pull_request, action, number)

    commit_status = "ready for release"

    repo
    |> create_or_find_commits(pull_request["commits"], commit_status)
    |> associate_commits_to_pull_request(created_pr)
    |> post_commits_to_ticket_tracker()

    # TODO: Need to send request to ticket tracking system
    json(conn, %{ok: "success"})
  end

  #################################################################################
  # All Private Methods are below
  # Accosicate commits to releases if they are not already
  #################################################################################
  defp post_commits_to_ticket_tracker(commits) do
    IO.inspect(commits)

    Enum.map(commits, fn commit ->
      loaded_commit = commit |> Repo.preload([:tickets])

      ticket_ids =
        Enum.map(loaded_commit.tickets, fn ticket ->
          %{id: ticket.ticket_id}
        end)

      IO.inspect(ticket_ids)
      query_text = "state " <> "\#" <> "{" <> "#{commit.status}" <> "}"

      data = %{
        query: query_text,
        issues: ticket_ids,
        comment: "See SHA ##{commit.sha}"
      }

      url = "https://webhook.site/8e5e1e1b-0432-4f81-affe-44895ceb1eb1"
      encoded_data = data |> Jason.encode!()
      HTTPoison.start()
      response = HTTPoison.post(url, encoded_data)

      IO.inspect(response)
    end)
  end

  defp associate_commits_to_pull_request(commits, pr) do
    pr
    |> Repo.preload([:commits])
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:commits, commits)
    |> Repo.update!()

    commits
  end

  defp find_or_create_pull_request_with_author(repo, pull_request, action, number) do
    author = find_or_create_author(pull_request["user"])
    created_pr = Tracker.get_pull_request(pull_request["id"])

    unless created_pr do
      {:ok, created_at_date_time, 0} = DateTime.from_iso8601(pull_request["created_at"])
      {:ok, updated_at_date_time, 0} = DateTime.from_iso8601(pull_request["updated_at"])
      {:ok, closed_at_date_time, 0} = DateTime.from_iso8601(pull_request["closed_at"])

      pr_attr = %{
        action: action,
        pr_number: number,
        status: pull_request["status"],
        id: pull_request["id"],
        body: pull_request["body"],
        number: pull_request["number"],
        title: pull_request["title"],
        head_sha: pull_request["head"]["sha"],
        pr_created_at: created_at_date_time,
        pr_updated_at: updated_at_date_time,
        pr_closed_at: closed_at_date_time,
        repository_id: repo.id
      }

      Ecto.build_assoc(author, :pull_requests, pr_attr) |> Repo.insert!()
    end

    Tracker.get_pull_request(pull_request["id"])
  end

  defp associate_commits_to_release(commits, release) do
    release
    |> Repo.preload([:commits])
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:commits, commits)
    |> Repo.update!()

    commits
  end

  defp find_or_create_release_with_author(release_params, released_at, repo, action) do
    author_params = release_params["author"]
    author = find_or_create_author(author_params)
    {:ok, released_at_date_time, 0} = DateTime.from_iso8601(released_at)
    created_release = Tracker.get_release(release_params["id"])
    # Create release only if it doesnt exists
    unless created_release do
      Ecto.build_assoc(author, :releases, %{
        id: release_params["id"],
        released_at: released_at_date_time,
        status: action,
        tag_name: release_params["tag_name"],
        repository_id: repo.id
      })
      |> Repo.insert!()
    end

    Tracker.get_release(release_params["id"])
  end

  defp find_or_create_repository(repo_params) do
    {:ok, _} =
      %Repository{}
      |> Repository.changeset(repo_params)
      |> Repo.insert(on_conflict: :nothing)

    Tracker.get_repository!(repo_params["id"])
  end

  defp find_or_create_author(author_params) do
    {:ok, _} =
      %Author{}
      |> Author.changeset(author_params)
      |> Repo.insert(on_conflict: :nothing)

    Tracker.get_author!(author_params["id"])
  end

  defp create_push_with_push_author_repository(repository, pushed_at, author) do
    {:ok, pushed_at_date_time, 0} = DateTime.from_iso8601(pushed_at)

    Ecto.build_assoc(author, :pushes, %{
      pushed_at: pushed_at_date_time,
      repository_id: repository.id
    })
    |> Repo.insert!()
  end

  defp create_commits_with_push_repo_author(push, repository, commits, status) do
    commits_created = create_or_find_commits(repository, commits, status)

    Enum.map(commits_created, fn commit ->
      Ecto.Changeset.change(commit, %{push_id: push.id}) |> Repo.update!()
    end)
  end

  defp create_or_find_commits(repository, commits, status) do
    Enum.map(commits, fn commit ->
      author = find_or_create_author(commit["author"])
      commit_created = Tracker.get_commit_by_sha(commit["sha"])

      unless commit_created do
        [commit_type, _, tickets] = String.split(commit["message"], ":")
        refined_tickets = get_tickets_list(tickets)

        # Datetime Parsing to match 
        {:ok, commit_date, 0} = DateTime.from_iso8601(commit["date"])

        commit_params = %{
          repository_id: repository.id,
          author_id: author.id,
          message: commit["message"],
          type: commit_type,
          sha: commit["sha"],
          date: commit_date,
          status: status
        }

        created_commit = %Commit{} |> Commit.changeset(commit_params) |> Repo.insert!()

        Enum.map(refined_tickets, fn ticket ->
          Ecto.build_assoc(created_commit, :tickets, %{
            ticket_id: String.replace(ticket, "#", ""),
            type: commit_type
          })
          |> Repo.insert!()
        end)
      else
        Tracker.get_commit_by_sha(commit["sha"])
        |> Ecto.Changeset.change(%{status: status})
        |> Repo.update!()
      end

      Tracker.get_commit_by_sha(commit["sha"])
    end)
  end

  defp get_tickets_list(tickets) do
    tck_list = String.split(tickets, ",")

    Enum.map(tck_list, fn item ->
      String.trim(item)
    end)
  end
end
