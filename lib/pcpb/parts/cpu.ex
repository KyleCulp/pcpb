defmodule Pcpb.Parts.CPU do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cpus" do
    field :name, :string
    field :manufacturer, :string
    field :model, :string
    field :model_year, :string
    field :model_number, :string
    field :family, :string
    field :series, :string
    field :socket, :string
    field :cache, :string
    field :cache_map, :map
    field :core_count, :integer
    field :core_clock, :decimal
    field :boost_clock, :decimal
    field :ecc_support, :string
    field :integrated_graphics, :string
    field :lithography, :string
    field :max_memory, :integer
    field :memory_channels, :integer
    field :smt, :string
    field :stock_cooler, :string
    field :tdp, :integer

    timestamps()
  end

  @doc false
  def changeset(cpu, attrs) do
    cpu
    |> cast(attrs, [:name, :manufacturer, :model, :model_year, :model_number, :series, :cache, :cache_map, :family, :integrated_graphics, :core_count, :core_clock, :boost_clock, :cache, :tdp, :lithography, :max_memory, :memory_channels, :smt, :stock_cooler])
    |> validate_required([:name, :manufacturer, :model, :model_year, :model_number, :series, :family, :integrated_graphics, :max_memory, :memory_channels, :smt, :core_count, :core_clock, :boost_clock, :cache, :tdp, :lithography, :stock_cooler])
  end
end
