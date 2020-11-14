defmodule Pcpb.Repo.Migrations.CreateCpus do
  use Ecto.Migration

  def change do
    create table(:cpus) do
      add :name, :string
      add :manufacturer, :string
      add :model, :string
      add :model_year, :string
      add :series, :string
      add :family, :string
      add :ecc_support, :string
      add :integrated_graphics, :string
      add :max_memory, :integer
      add :memory_channels, :integer
      add :simultaneous_multithreading, :string
      add :core_count, :integer
      add :core_clock, :integer
      add :boost_clock, :integer
      add :cache, :string
      add :tdp, :integer
      add :boost_tdp, :integer
      add :lithography, :string
      add :stock_cooler, :string

      timestamps()
    end

  end
end
