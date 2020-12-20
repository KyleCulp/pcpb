defmodule Pcpb.Repo.Migrations.CreatePsus do
  use Ecto.Migration
  import Pcpb.Parts.Base

  def change do
    create table(:psus) do
      part_base_fields_migration

      add :dimensions, :map
      add :series, :string
      add :color, :string
      add :efficiency, :string
      add :type, :string
      add :wattage, :integer
      add :form_factor, :string
      add :modular, :string
      add :rating, :string
      add :fan_bearing, :string
      add :fan_size, :string
      add :fan_dba, :string
      add :main_connector, :string
      add :pci_express_connector, :string
      add :sata_connectors, :integer
      add :molex_connectors, :integer
      add :twelvevrails, :integer
      add :input_current, :string
      add :input_voltage, :string
      add :manufacturer_warranty, :string
      add :MTBF, :string
      add :weight, :integer
      add :cable_type, :string
      add :rgb, :string
      add :connectors, {:array, :string}
      timestamps()
    end

  end
end
