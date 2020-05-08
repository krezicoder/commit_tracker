defmodule CommitTracker.Tracker.Push do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommitTracker.Tracker.Repository

  schema "pushes" do
    field :pushed_at, :utc_datetime

    timestamps()
    belongs_to :repository, Repository
  end

  @doc false
  def changeset(push, attrs) do
    push
    |> cast(attrs, [:pushed_at])
    |> validate_required([:pushed_at])
  end
end
