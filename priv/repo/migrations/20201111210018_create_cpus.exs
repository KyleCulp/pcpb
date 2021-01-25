defmodule Pcpb.Repo.Migrations.CreateCpus do
  use Ecto.Migration
  import Pcpb.Parts.Base

  def change do
    create table(:cpus, primary_key: false) do
      part_base_fields_migration
      add :family, :string
      add :series, :string
      add :socket, :string
      add :unlocked, :boolean
      add :pci_version, :string
      add :memory_type, :string
      add :cache, :string
      add :cache_map, :map
      add :core_count, :integer
      add :core_clock, :decimal
      add :boost_clock, :decimal
      add :integrated_graphics, :string
      add :lithography, :string
      add :tdp, :integer
      add :ecc_support, :string
      add :max_memory, :integer
      add :memory_channels, :integer
      add :smt, :string
      add :stock_cooler, :string

      timestamps()
    end
  end
end
