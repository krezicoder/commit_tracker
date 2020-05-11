defmodule CommitTracker.Tracker.Release do
  use Ecto.Schema
  import Ecto.Changeset

  schema "releases" do
    field :released_at, :utc_datetime
    field :status, :string
    field :tag_name, :string
    field :repository_id, :id
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(release, attrs) do
    release
    |> cast(attrs, [:status, :released_at, :tag_name])
    |> validate_required([:status, :released_at, :tag_name])
  end
end
