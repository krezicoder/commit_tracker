defmodule CommitTrackerWeb.WebhookController do
  use CommitTrackerWeb, :controller
  alias CommitTracker.Tracker.{Repository, Push}
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
    find_or_create_repository(repository)
    |> create_push(pushed_at)
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

  defp create_push(repository, pushed_at) do
    {:ok, pushed_at_date_time, 0} = DateTime.from_iso8601(pushed_at)

    Ecto.build_assoc(repository, :pushes, %{pushed_at: pushed_at_date_time})
    |> Repo.insert!()
  end
end
