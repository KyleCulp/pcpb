defmodule Pcpb.Repo.Migrations.CreateGpus do
  use Ecto.Migration
  import Pcpb.Parts.Base

  def change do
    create table(:gpus) do
      part_base_fields_migration
      add :series, :string
      add :chipset, :string
      add :GPU, :string
      add :interface, :string
      add :directx, :string
      add :opengl, :string
      add :cuda_cores, :integer
      add :stream_processors, :integer
      add :base_clock, :decimal
      add :boost_clock, :decimal
      add :memory, :string
      add :memory_clock, :string
      add :memory_type, :string
      add :memory_interface, :string
      add :sli_support, :string
      add :crossfire_support, :string
      add :frame_sync, :string
      add :slot_width, :string
      add :max_resolution, :string
      add :max_monitors, :integer
      add :power_connector, :string
      add :ray_tracing, :string
      add :cooler, :string
      add :hdcp, :string
      add :backplate, :string
      add :io, {:array, :string}
      add :color, :string
      add :rgb, :string
      add :dimensions, :map
      add :tdp, :decimal
      add :weight, :decimal

      timestamps()
    end

  end
end
