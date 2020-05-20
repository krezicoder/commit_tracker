defmodule CommitTracker.Repo.Migrations.PullRequestsCommits do
  use Ecto.Migration

  def change do
    create table(:pull_requests_commits) do
      add(:pull_request_id, references(:pull_requests))
      add(:commit_id, references(:commits))
    end
  end
end
