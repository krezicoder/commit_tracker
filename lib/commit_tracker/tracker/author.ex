defmodule CommitTracker.Tracker.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommitTracker.Tracker.{Push, Commit}

  schema "authors" do
    field :email, :string
    field :name, :string

    timestamps()
    has_many :pushes, Push
    has_many :commits, Commit
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:id, :name, :email])
    |> validate_required([:id, :name, :email])
    |> unique_constraint(:email)
  end
end
