defmodule CommitTracker.Tracker.Release do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommitTracker.Tracker.{Repository, Author, Commit}

  schema "releases" do
    field :released_at, :utc_datetime
    field :status, :string
    field :tag_name, :string

    belongs_to :repository, Repository
    belongs_to :author, Author

    many_to_many :commits, Commit, join_through: "releases_commits", on_replace: :mark_as_invalid
    timestamps()
  end

  @doc false
  def changeset(release, attrs) do
    release
    |> cast(attrs, [:id, :status, :released_at, :tag_name, :repository_id, :author_id])
    |> validate_required([:id, :repository_id, :author_id, :status, :released_at, :tag_name])
  end
end
