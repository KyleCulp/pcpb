defmodule Pcpb.Parts.CPU do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cpus" do
    field :boost_clock, :integer
    field :boost_tdp, :integer
    field :cache, :string
    field :core_clock, :integer
    field :core_count, :integer
    field :ecc_support, :string
    field :family, :string
    field :integrated_graphics, :string
    field :lithography, :string
    field :manufacturer, :string
    field :max_memory, :integer
    field :memory_channels, :integer
    field :model, :string
    field :model_year, :string
    field :name, :string
    field :series, :string
    field :simultaneous_multithreading, :string
    field :stock_cooler, :string
    field :tdp, :integer

    timestamps()
  end

  @doc false
  def changeset(cpu, attrs) do
    cpu
    |> cast(attrs, [:name, :manufacturer, :model, :model_year, :series, :family, :integrated_graphics, :max_memory, :memory_channels, :simultaneous_multithreading, :core_count, :core_clock, :boost_clock, :cache, :tdp, :boost_tdp, :lithography, :stock_cooler])
    |> validate_required([:name, :manufacturer, :model, :model_year, :series, :family, :integrated_graphics, :max_memory, :memory_channels, :simultaneous_multithreading, :core_count, :core_clock, :boost_clock, :cache, :tdp, :boost_tdp, :lithography, :stock_cooler])
  end
end
