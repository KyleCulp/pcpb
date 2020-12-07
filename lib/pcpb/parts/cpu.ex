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
    embeds_one :cache_map, CacheMap do
      field :l1instruction, :string
      field :l1data, :string
      field :l2, :string
      field :l3, :string
    end
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
    |> cast(attrs, [
      :name,
      :manufacturer,
      :model,
      :model_year,
      :model_number,
      :series,
      :socket,
      :ecc_support,
      :cache,
      :family,
      :integrated_graphics,
      :core_count,
      :core_clock,
      :boost_clock,
      :cache,
      :tdp,
      :lithography,
      :max_memory,
      :memory_channels,
      :smt,
      :stock_cooler
    ])
    |> validate_required([
      :name,
      :manufacturer,
      :model,
      :model_year,
      :model_number,
      :series,
      :family,
      :integrated_graphics,
      :max_memory,
      :memory_channels,
      :smt,
      :core_count,
      :core_clock,
      :boost_clock,
      :cache,
      :tdp,
      :lithography,
      :stock_cooler
    ])
    |> cast_embed(:cache_map, with: &cache_map_changeset/2)
  end

  defp cache_map_changeset(schema, params) do
    schema
    |> cast(params, [:l1instruction, :l1data, :l2, :l3])
  end
end
