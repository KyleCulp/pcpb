defmodule Pcpb.Repo.Migrations.CreateCpuCoolers do
  use Ecto.Migration
  import Pcpb.Parts.Base

  def change do
    create table(:cpu_coolers, primary_key: false) do
      part_base_fields_migration
      add :dimensions, :map
      add :series, :string
      add :color, :string
      add :led, :string
      add :type, :string
      add :socket_support, {:array, :string}
      add :bearing_type, :string
      add :fans, :string
      add :fan_size, :string
      add :fan_cfm, :string
      add :fan_rpm, :string
      add :noise_level, :string
      add :radiator, :string

      timestamps()
    end
  end
end
