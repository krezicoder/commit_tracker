defmodule CommitTracker.Repo.Migrations.CreatePushes do
  use Ecto.Migration

  def change do
    create table(:pushes) do
      add(:pushed_at, :utc_datetime)
      add(:repository_id, references(:repositories, on_delete: :nothing))

      timestamps()
    end

    create(index(:pushes, [:repository_id]))
  end
end
