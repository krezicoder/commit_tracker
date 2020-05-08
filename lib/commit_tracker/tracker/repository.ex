defmodule CommitTracker.Tracker.Repository do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommitTracker.Tracker.{Push, Commit}

  schema "repositories" do
    field :name, :string

    timestamps()

    has_many :pushes, Push
    has_many :commits, Commit
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
    |> validate_inclusion(:name, ["ember_app", "suitepad_api", "suite_apk"])
  end
end
