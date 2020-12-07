defmodule Pcpb.Repo.Migrations.CreateCpuCoolers do
  use Ecto.Migration

  def change do
    create table(:cpu_coolers) do
      add :name, :string
      add :manufacturer, :string
      add :model, :string
      add :series, :string
      add :release, :date
      add :model_number, :string
      add :color, :string
      add :led, :string
      add :type, :string
      add :intel_socket_support, {:array, :string}
      add :amd_socket_support, {:array, :string}
      add :bearing_type, :string
      add :fans, :integer
      add :fan_size, :integer
      add :rpm, :string
      add :noise_level, :string
      add :fan_cfm, :string
      add :dimensions, :map
      add :watercool, :map
      add :fan_dimensions, :string
      add :rgb, :string

      timestamps()
    end

  end
end
