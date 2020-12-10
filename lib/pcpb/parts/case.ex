defmodule Pcpb.Parts.Case do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cases" do
    field :name, :string
    field :manufacturer, :string
    field :model, :string
    field :model_number, :string
    field :launch, :date
    field :color, :string
    field :material, :string
    field :type, :string
    field :motherboard_support, {:array, :string}
    field :psu_support, {:array, :string}
    field :psu_mount_location, :string
    field :psu_shroud, :string
    field :included_psu, :string
    field :weight, :decimal

    embeds_one :clearance, ClearanceMap do
      field :gpu_length, :decimal
      field :cpu_cooler_height, :decimal
      field :psu_length, :decimal
    end

    embeds_one :dimensions, DimensionsMap do
      field :length, :decimal
      field :width, :decimal
      field :height, :decimal
    end

    embeds_one :dust_filters, DustFiltersMap do
      field :front, :boolean
      field :back, :boolean
      field :top, :boolean
      field :bottom, :boolean
      field :psu, :boolean
    end

    embeds_one :fan_options, FanOptionsMap do
      field :front, {:array, :string}
      field :back, {:array, :string}
      field :top, {:array, :string}
      field :bottom, {:array, :string}
    end

    embeds_one :radiator_support, RadiatorSupportMap do
      field :front, :string
      field :back, :string
      field :top, :string
      field :bottom, :string
    end

    field :expansion_slots, :integer
    field :fiveonefourthbays, :integer
    field :threeonehalfbays, :integer
    field :side_window, :string
    field :io, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(case, attrs) do
    case
    |> cast(attrs, [
      :name,
      :manufacturer,
      :model,
      :model_number,
      :launch,
      :color,
      :material,
      :type,
      :motherboard_support,
      :psu_support,
      :psu_mount_location,
      :psu_shroud,
      :included_psu,
      :weight,
      :expansion_slots,
      :fiveonefourthbays,
      :threeonehalfbays,
      :side_window,
      :io
    ])
    |> validate_required([
      :name,
      :manufacturer,
      :model,
      :launch,
      :model_number,
      :color,
      :type,
      :motherboard_support,
      :psu_support,
      :included_psu,
      :psu_shroud,
      :psu_mount_location
    ])
    |> cast_embed(:clearance, with: &clearance_map_changeset/2)
    |> cast_embed(:dimensions, with: &dimensions_map_changeset/2)
    |> cast_embed(:dust_filters, with: &dust_filters_map_changeset/2)
    |> cast_embed(:fan_options, with: &fan_options_map_changeset/2)
    |> cast_embed(:radiator_support, with: &radiator_support_map_changeset/2)
  end

  defp clearance_map_changeset(schema, params) do
    schema
    |> cast(params, [:gpu_length, :cpu_cooler_height, :psu_length])
    |> validate_required([
      :gpu_length,
      :cpu_cooler_height,
      :psu_length
    ])
  end

  defp dimensions_map_changeset(schema, params) do
    schema
    |> cast(params, [:length, :width, :height])
    |> validate_required([
      :length,
      :width,
      :height
    ])
  end

  defp dust_filters_map_changeset(schema, params) do
    schema
    |> cast(params, [:front, :back, :top, :bottom, :psu])

    # |> validate_required([
    #   :front,
    #   :back,
    #   :top,
    #   :bottom,
    #   :psu
    # ])
  end

  defp fan_options_map_changeset(schema, params) do
    schema
    |> cast(params, [:front, :back, :top, :bottom])

    # |> validate_required([
    #   :front,
    #   :back,
    #   :top,
    #   :bottom
    # ])
  end

  defp radiator_support_map_changeset(schema, params) do
    schema
    |> cast(params, [:front, :back, :top, :bottom])

    # |> validate_required([
    #   :front,
    #   :back,
    #   :top,
    #   :bottom
    # ])
  end
end
