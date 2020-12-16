defmodule Pcpb.Parts.CPUCooler do
  use Ecto.Schema
  import Ecto.Changeset
  import Pcpb.Parts.Base
  alias Parts

  schema "cpu_coolers" do
    part_base_fields()

    field :series, :string
    field :color, :string
    field :led, :string
    field :type, :string
    field :socket_support, {:array, :string}
    field :bearing_type, :string
    field :fans, :string
    field :fan_size, :string
    field :fan_cfm, :string
    field :fan_rpm, :string
    field :noise_level, :string
    field :radiator, :string
    timestamps()

  end

  @doc false
  def changeset(cpu_cooler, attrs) do
    cpu_cooler
    |> part_base_fields_changeset(attrs)
    |> cast(attrs, [
      :color,
      :led,
      :type,
      :socket_support,
      :bearing_type,
      :fans,
      :fan_size,
      :fan_rpm,
      :noise_level,
      :fan_cfm,
      :radiator
    ])
    |> validate_required([
      :color,
      :led,
      :type,
      :socket_support,
      :bearing_type,
      :fans,
      :fan_size,
      :fan_rpm,
      :noise_level,
      :fan_cfm,
      :radiator
    ])
    # |> cast_embed(:dimensions, with: &Base.dimensions_map_changeset/2)
  end
end
