defmodule Pcpb.Parts.CPU do
  use Ecto.Schema
  import Pcpb.Parts.Base
  import Ecto.Changeset

  schema "cpus" do
    part_base_fields()

    field :family, :string
    field :series, :string
    field :socket, :string
    field :unlocked, :boolean
    field :pci_version, :string
    field :memory_type, :string
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
    field :integrated_graphics, :string
    field :lithography, :string
    field :tdp, :integer
    field :ecc_support, :string
    field :max_memory, :integer
    field :memory_channels, :integer
    field :smt, :string
    field :stock_cooler, :string

    timestamps()
  end

  @doc false
  def changeset(cpu, attrs) do
    cpu
    |> part_base_fields_changeset(attrs)
    |> cast(attrs, [
      :series,
      :socket,
      :unlocked,
      :pci_version,
      :memory_type,
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
      :series,
      :socket,
      :unlocked,
      :pci_version,
      :memory_type,
      :ecc_support,
      :family,
      :integrated_graphics,
      :core_count,
      :core_clock,
      :boost_clock,
      :tdp,
      :lithography,
      :max_memory,
      :memory_channels,
      :smt,
      :stock_cooler
    ])
    |> cast_embed(:cache_map, with: &cache_map_changeset/2)
  end

  defp cache_map_changeset(schema, params) do
    schema
    |> cast(params, [:l1instruction, :l1data, :l2, :l3])

    # |> validate_required([
    #   :l1instruction,
    #   :l1data,
    #   :l2,
    #   :l3
    # ])
  end
end
