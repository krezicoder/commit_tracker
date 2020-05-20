defmodule CommitTracker.Repo.Migrations.ReleaseCommits do
  use Ecto.Migration

  def change do
    create table(:releases_commits) do
      add(:release_id, references(:releases))
      add(:commit_id, references(:commits))
    end
  end
end
