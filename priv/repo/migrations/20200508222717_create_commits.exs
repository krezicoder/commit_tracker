defmodule CommitTracker.Repo.Migrations.CreateCommits do
  use Ecto.Migration

  def change do
    create table(:commits) do
      add :sha, :string
      add :message, :string
      add :date, :utc_datetime
      add :type, :string
      add :author_id, references(:authors, on_delete: :nothing)
      add :repository_id, references(:repositories, on_delete: :nothing)
      add :push_id, references(:pushes, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:commits, [:sha])
    create index(:commits, [:author_id])
    create index(:commits, [:repository_id])
    create index(:commits, [:push_id])
  end
end
