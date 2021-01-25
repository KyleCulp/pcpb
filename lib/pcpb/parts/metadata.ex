defmodule Pcpb.Parts.Metadata do
  use Ecto.Schema
  import Ecto.Changeset

  schema "metadatas" do
    field :edits, {:array, :map}
    has_one :part_id, Pcpb.Parts.Part
    # belongs_to :created_by, Pcpb.Users.User, type: :string

    timestamps()
  end

  @doc false
  def changeset(metadata, attrs) do
    metadata
    |> cast(attrs, [:edits])
    |> validate_required([:edits])
  end
end
