defmodule Pcpb.Parts.Part do
  use Ecto.Schema
  import Pcpb.Parts.Base
  import Ecto.Changeset

  @part_types [:cpu, :cpu_cooler, :case, :gpu, :memory, :psu]
  def part_types, do: @part_types

  @primary_key {:id, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :id}

  schema "parts" do
    field :part_type, Ecto.Enum, values: @part_types
    has_many :products, Pcpb.App.Product

    timestamps()
  end

  @doc false
  def changeset(part, attrs) do
    part
    |> cast(attrs, [:id, :part_type])
    |> validate_required([:id, :part_type])
    # |> cast_assoc(:product, required: false)
  # |> Map.merge(%{id: generate_product_id})
  end
end
