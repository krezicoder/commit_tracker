defmodule CommitTracker.Tracker.PullRequest do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommitTracker.Tracker.{Author, Repository, Commit}

  schema "pull_requests" do
    field :action, :string
    field :body, :string
    field :pr_closed_at, :utc_datetime
    field :pr_created_at, :utc_datetime
    field :head_sha, :string
    field :merge_commit_sha, :string
    field :number, :integer
    field :request_number, :integer
    field :state, :string
    field :title, :string
    field :pr_updated_at, :utc_datetime

    belongs_to :author, Author
    belongs_to :repository, Repository
    timestamps()

    many_to_many :commits, Commit,
      join_through: "pull_requests_commits",
      on_replace: :mark_as_invalid
  end

  @doc false
  def changeset(pull_request, attrs) do
    pull_request
    |> cast(attrs, [
      :id,
      :repository_id,
      :author_id,
      :number,
      :request_number,
      :action,
      :state,
      :title,
      :body,
      :created_at,
      :updated_at,
      :closed_at,
      :merge_commit_sha,
      :head_sha
    ])
    |> validate_required([
      :number,
      :request_number,
      :action,
      :state,
      :title,
      :body,
      :created_at,
      :updated_at,
      :closed_at,
      :merge_commit_sha,
      :head_sha
    ])
  end
end
