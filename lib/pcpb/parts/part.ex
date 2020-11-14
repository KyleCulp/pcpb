defmodule Pcpb.Parts.Part do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts" do
    field :name, :string
    field :partid, :integer

    timestamps()
  end

  @doc false
  def changeset(part, attrs) do
    part
    |> cast(attrs, [:name, :partid])
    |> validate_required([:name, :partid])
  end
end
