defmodule CommitTracker.Repo.Migrations.CreatePullRequests do
  use Ecto.Migration

  def change do
    create table(:pull_requests) do
      add(:number, :integer)
      add(:request_number, :integer)
      add(:action, :string)
      add(:state, :string)
      add(:title, :string)
      add(:body, :string)
      add(:pr_created_at, :utc_datetime)
      add(:pr_updated_at, :utc_datetime)
      add(:pr_closed_at, :utc_datetime)
      add(:merge_commit_sha, :string)
      add(:head_sha, :string)
      add(:repository_id, references(:repositories, on_delete: :nothing))
      add(:author_id, references(:authors, on_delete: :nothing))

      timestamps()
    end

    create(index(:pull_requests, [:repository_id]))
    create(index(:pull_requests, [:author_id]))
  end
end
