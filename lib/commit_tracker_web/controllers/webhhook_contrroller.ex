defmodule CommitTrackerWeb.WebhookController do
  use CommitTrackerWeb, :controller
  alias CommitTracker.Tracker.{Repository, Push, Author, Commit}
  alias CommitTracker.Repo
  alias CommitTracker.Tracker

  def actions(
        conn,
        %{
          "commits" => commits,
          "repository" => repository,
          "pushed_at" => pushed_at,
          "pusher" => pusher
        }
      ) do
    push_author = find_or_create_author(pusher)

    push =
      find_or_create_repository(repository)
      |> create_push_with_push_author_repository(pushed_at, push_author)
      |> create_commits_with_push_repo_author(repository, commits)

    json(conn, %{ok: "success"})
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

    push =
      Ecto.build_assoc(author, :pushes, %{
        pushed_at: pushed_at_date_time,
        repository_id: repository.id
      })
      |> Repo.insert!()
  end

  defp create_push_author(push, author) do
    {:ok, push_assoc} =
      Ecto.build_assoc(author, :pushes, push)
      |> Repo.insert!()

    IO.inspect(push_assoc)
    push_assoc
  end

  defp create_commits_with_push_repo_author(push, repository, commits) do
    Enum.map(commits, fn commit ->
      IO.inspect(commit)
      author = find_or_create_author(commit["author"])
      [commit_type, _, _] = String.split(commit["message"], ":")
      {:ok, commit_date, 0} = DateTime.from_iso8601(commit["date"])

      commit_params = %{
        repository_id: repository["id"],
        author_id: author.id,
        push_id: push.id,
        message: commit["message"],
        type: commit_type,
        sha: commit["sha"],
        date: commit_date
      }

      %Commit{} |> Commit.changeset(commit_params) |> Repo.insert!()
      IO.inspect(commit)
    end)
  end
end
