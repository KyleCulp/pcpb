defmodule Pcpb.Repo.Migrations.CreateCases do
  use Ecto.Migration

  def change do
    create table(:cases) do
      add :name, :string
      add :manufacturer, :string
      add :model, :string
      add :release, :date
      add :model_number, :string
      add :color, :string
      add :type, :string
      add :motherboard_support, {:array, :string}
      add :psu_support, {:array, :string}
      add :included_psu, :string
      add :psu_shroud, :string
      add :psu_mount_location, :string
      add :windows, :map
      add :dimensions, :map
      add :clearance, :map
      add :weight, :decimal
      add :io, :map
      add :dust_filters, :map
      add :expansion_slots, :map
      add :radiator_support, :map
      add :fan_options, :map

      timestamps()
    end

  end
end
