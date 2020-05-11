defmodule CommitTracker.Repo.Migrations.CreateReleases do
  use Ecto.Migration

  def change do
    create table(:releases) do
      add :status, :string
      add :released_at, :utc_datetime
      add :tag_name, :string
      add :repository_id, references(:repositories, on_delete: :nothing)
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:releases, [:repository_id])
    create index(:releases, [:author_id])
  end
end
