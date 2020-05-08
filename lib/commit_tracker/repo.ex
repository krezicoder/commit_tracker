defmodule CommitTracker.Repo do
  use Ecto.Repo,
    otp_app: :commit_tracker,
    adapter: Ecto.Adapters.Postgres
end
