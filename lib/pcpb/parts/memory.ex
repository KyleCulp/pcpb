defmodule Pcpb.Parts.Memory do
  use Ecto.Schema
  import Ecto.Changeset
  use Pcpb.Parts.Base
  import Pcpb.Parts.Base

  schema "memorys" do
    part_base_fields()
    field :series, :string
    field :type, :string
    field :chipset, :string
    field :color, :string
    field :cas_latency, :integer
    field :heatsink, :string
    field :module_size, :string
    field :speed, :string
    field :speeed_rating, :string
    field :timing, :string
    field :voltage, :string
    field :ecc, :string
    field :ecc_rank, :string
    field :led, :string

    timestamps()
  end

  @doc false
  def changeset(memory, attrs) do
    memory
    |> part_base_fields_changeset(attrs)
    |> cast(attrs, [
      :series,
      :color,
      :led,
      :type,
      :chipset,
      :module_size,
      :speed,
      :speeed_rating,
      :cas_latency,
      :voltage,
      :timing,
      :heatsink,
      :ecc,
      :ecc_rank
    ])
    |> validate_required([
      :name,
      :manufacturer,
      :model,
      :launch,
      :model_number,
      :series,
      :color,
      :led,
      :type,
      :chipset,
      :module_size,
      :speed,
      :cas_latency,
      :voltage,
      :timing,
      :heatsink,
      :ecc
    ])
  end
end
