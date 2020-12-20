defmodule Pcpb.Parts.PSU do
  use Ecto.Schema
  import Ecto.Changeset
  import Pcpb.Parts.Base

  schema "psus" do
    part_base_fields()
    dimensions_map()

    field :series, :string
    field :color, :string
    field :efficiency, :string
    field :type, :string
    field :wattage, :integer
    field :form_factor, :string
    field :modular, :string
    field :rating, :string
    field :fan_bearing, :string
    field :fan_size, :string
    field :fan_dba, :string
    field :main_connector, :string
    field :pci_express_connector, :string
    field :twelvevrails, :integer
    field :sata_connectors, :integer
    field :input_current, :string
    field :input_voltage, :string
    field :manufacturer_warranty, :string
    field :MTBF, :string
    field :weight, :integer
    field :cable_type, :string
    field :rgb, :string
    field :connectors, {:array, :string}
    timestamps()
  end

  @doc false
  def changeset(psu, attrs) do
    psu
    |> part_base_fields_changeset(attrs)
    |> cast_embed(:dimensions, with: &dimensions_map_changeset/2, force_update_on_change: true)
    |> cast(attrs, [
      :series,
      :color,
      :efficiency,
      :type,
      :wattage,
      :form_factor,
      :modular,
      :rating,
      :fan_bearing,
      :fan_size,
      :fan_dba,
      :main_connector,
      :pci_express_connector,
      :twelvevrails,
      :sata_connectors,
      :input_current,
      :input_voltage,
      :manufacturer_warranty,
      :MTBF,
      :weight,
      :cable_type,
      :rgb,
      :connectors
    ])
    |> validate_required([
      :series,
      :color,
      :efficiency,
      :type,
      :wattage,
      :form_factor,
      :modular,
      :rating,
      :fan_bearing,
      :fan_size,
      :fan_dba,
      :main_connector,
      :pci_express_connector,
      :twelvevrails,
      :sata_connectors,
      :input_current,
      :input_voltage,
      :manufacturer_warranty,
      :MTBF,
      :weight,
      :cable_type,
      :rgb,
      :connectors
    ])
  end
end