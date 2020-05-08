defmodule CommitTracker.Repo.Migrations.PushAuthor do
  use Ecto.Migration

  def change do
    alter table(:pushes) do
      add(:author_id, references(:authors, on_delete: :nothing))
    end
  end
end
