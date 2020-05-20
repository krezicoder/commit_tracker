defmodule CommitTracker.Repo.Migrations.AddStatusToCommit do
  use Ecto.Migration

  def change do
    alter table(:commits) do
      add(:status, :string)
    end
  end
end
