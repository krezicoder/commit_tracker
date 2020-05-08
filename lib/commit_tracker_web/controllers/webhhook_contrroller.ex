defmodule CommitTrackerWeb.WebhookController do
  use CommitTrackerWeb, :controller
  alias CommitTracker.Tracker.Repository
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
    IO.inspect(find_or_create_repository(repository))
    json(conn, %{ok: "success"})
  end

  defp find_or_create_repository(repo_params) do
    {:ok, _} =
      %Repository{}
      |> Repository.changeset(repo_params)
      |> Repo.insert(on_conflict: :nothing)

    Tracker.get_repository!(repo_params["id"])
  end
end
