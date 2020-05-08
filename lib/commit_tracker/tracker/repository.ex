defmodule CommitTracker.Tracker.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
    |> validate_inclusion(:name, ["ember_app", "suitepad_api", "suite_apk"])
  end
end
