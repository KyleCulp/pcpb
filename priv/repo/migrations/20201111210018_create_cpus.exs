defmodule Pcpb.Repo.Migrations.CreateCpus do
  use Ecto.Migration

  def change do
    create table(:cpus) do
      add :name, :string
      add :manufacturer, :string
      add :model, :string
      add :model_year, :string
      add :model_number, :string
      add :family, :string
      add :series, :string
      add :socket, :string
      add :cache, :string
      add :cache_map, :map
      add :ecc_support, :string
      add :integrated_graphics, :string
      add :max_memory, :integer
      add :memory_channels, :integer
      add :smt, :string
      add :core_count, :integer
      add :core_clock, :decimal
      add :boost_clock, :decimal
      add :tdp, :integer
      add :lithography, :string
      add :stock_cooler, :string

      timestamps()
    end

  end
end
