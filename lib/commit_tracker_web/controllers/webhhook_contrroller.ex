defmodule CommitTrackerWeb.WebhookController do
  use CommitTrackerWeb, :controller
  alias CommitTracker.Tracker.{Repository, Push, Author}
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
    author = find_or_create_author(pusher)

    find_or_create_repository(repository)
    |> create_push(pushed_at)
    |> create_push_author(author)
    |> IO.inspect()

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

  defp create_push(repository, pushed_at) do
    {:ok, pushed_at_date_time, 0} = DateTime.from_iso8601(pushed_at)

    Ecto.build_assoc(repository, :pushes, %{pushed_at: pushed_at_date_time})
    |> Repo.insert!()
  end

  defp create_push_author(push, author) do
    push_assoc = Ecto.build_assoc(author, :pushes, push)

    IO.inspect(push_assoc)
    |> Repo.insert!()
  end
end
