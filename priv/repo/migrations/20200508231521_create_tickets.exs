defmodule CommitTracker.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :ticket_id, :string
      add :type, :string
      add :commit_id, references(:commits, on_delete: :nothing)

      timestamps()
    end

    create index(:tickets, [:commit_id])
  end
end
