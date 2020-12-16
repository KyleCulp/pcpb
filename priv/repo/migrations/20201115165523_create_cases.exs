defmodule Pcpb.Repo.Migrations.CreateCases do
  use Ecto.Migration
  import Pcpb.Parts.Base

  def change do
    create table(:cases) do
      part_base_fields_migration
      add :color, :string
      add :material, :string
      add :type, :string
      add :motherboard_support, {:array, :string}
      add :psu_support, {:array, :string}
      add :psu_mount_location, :string
      add :psu_shroud, :string
      add :included_psu, :string
      add :weight, :decimal

      add :clearance, :map
      add :dimensions, :map
      add :dust_filters, :map
      add :radiator_support, :map
      add :fan_options, :map

      add :expansion_slots, :integer
      add :fiveonefourthbays, :integer
      add :threeonehalfbays, :integer
      add :side_window, :string
      add :io, {:array, :string}

      timestamps()
    end
  end
end
