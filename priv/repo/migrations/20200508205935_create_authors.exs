defmodule CommitTracker.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:authors, [:email])
  end
end
