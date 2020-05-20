defmodule CommitTracker.Tracker.Commit do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommitTracker.Tracker.{Author, Repository, Push, Ticket, Release, PullRequest}

  schema "commits" do
    field :date, :utc_datetime
    field :message, :string
    field :sha, :string
    field :type, :string

    timestamps()
    belongs_to :author, Author
    belongs_to :push, Push
    belongs_to :repository, Repository
    has_many :tickets, Ticket

    many_to_many :releases, Release,
      join_through: "releases_commits",
      on_replace: :mark_as_invalid

    many_to_many :pull_requests, PullRequest,
      join_through: "pull_requests_commits",
      on_replace: :mark_as_invalid
  end

  @doc false
  def changeset(commit, attrs) do
    commit
    |> cast(attrs, [:sha, :message, :date, :type, :repository_id, :push_id, :author_id])
    |> validate_required([:sha, :message, :date, :type])
    |> unique_constraint(:sha)
  end
end
