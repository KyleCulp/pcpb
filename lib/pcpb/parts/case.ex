  defmodule Pcpb.Parts.Case do
    use Ecto.Schema
    import Ecto.Changeset
    import Pcpb.Parts.Base

    schema "cases" do
      part_base_fields()
      dimensions_map()
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
      |> part_base_fields_changeset(attrs)
      |> cast(attrs, [
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
        :side_window
      ])
      |> cast_embed(:dimensions, with: &dimensions_map_changeset/2)
      |> cast_embed(:clearance, with: &clearance_map_changeset/2)
      |> cast_embed(:dust_filters, with: &dust_filters_map_changeset/2)
      |> cast_embed(:fan_options, with: &fan_options_map_changeset/2)
      |> cast_embed(:radiator_support, with: &radiator_support_map_changeset/2)
    end

    def clearance_map_changeset(schema, params) do
      schema
      |> cast(params, [:gpu_length, :cpu_cooler_height, :psu_length])
      |> validate_required([
        :gpu_length,
        :cpu_cooler_height,
        :psu_length
      ])
    end

    def dust_filters_map_changeset(schema, params) do
      schema |> cast(params, [:front, :back, :top, :bottom, :psu])
    end

    def fan_options_map_changeset(schema, params) do
      schema |> cast(params, [:front, :back, :top, :bottom])
    end

    def radiator_support_map_changeset(schema, params) do
      schema |> cast(params, [:front, :back, :top, :bottom])
    end
  end
