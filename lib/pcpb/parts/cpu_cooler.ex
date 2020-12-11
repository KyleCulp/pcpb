defmodule Pcpb.Parts.CPUCooler do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cpu_coolers" do
    field :bearing_type, :string
    field :color, :string
    field :dimensions, :map
    field :fan_cfm, :string
    field :fan_dimensions, :string
    field :fan_size, :integer
    field :fans, :integer
    field :intel_socket_support, {:array, :string}
    field :amd_socket_support, {:array, :string}
    field :led, :string
    field :manufacturer, :string
    field :model, :string
    field :model_number, :string
    field :name, :string
    field :noise_level, :string
    field :release, :date
    field :rgb, :string
    field :rpm, :string
    field :series, :string
    field :type, :string
    field :watercool, :map

    timestamps()
  end

  @doc false
  def changeset(cpu_cooler, attrs) do
    cpu_cooler
    |> cast(attrs, [
      :name,
      :manufacturer,
      :model,
      :series,
      :release,
      :model_number,
      :color,
      :led,
      :type,
      :intel_socket_support,
      :amd_socket_support,
      :bearing_type,
      :fans,
      :fan_size,
      :rpm,
      :noise_level,
      :fan_cfm,
      :dimensions,
      :watercool,
      :fan_dimensions,
      :rgb
    ])
    |> validate_required([
      :name,
      :manufacturer,
      :model,
      :series,
      :release,
      :model_number,
      :color,
      :led,
      :type,
      :intel_socket_support,
      :amd_socket_support,
      :bearing_type,
      :fans,
      :fan_size,
      :rpm,
      :noise_level,
      :fan_cfm,
      :dimensions,
      :watercool,
      :fan_dimensions,
      :rgb
    ])
  end
end
