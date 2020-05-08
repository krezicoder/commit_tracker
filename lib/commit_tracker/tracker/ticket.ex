defmodule CommitTracker.Tracker.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommitTracker.Tracker.Commit

  schema "tickets" do
    field :ticket_id, :string
    field :type, :string

    timestamps()
    belongs_to :commit, Commit
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:ticket_id, :type])
    |> validate_required([:ticket_id, :type])
  end
end
