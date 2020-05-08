defmodule CommitTracker.Tracker.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
