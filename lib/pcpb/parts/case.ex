defmodule Pcpb.Parts.Case do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cases" do
    field :clearance, :map
    field :color, :string
    field :dimensions, :map
    # embeds_one :dimensions, Dimensions, on_replace: :update do
    #   field(:length, :decimal)
    #   field(:width, :decimal)
    #   field(:height, :decimal)
    #   field(:height, :decimal)
    # end
    field :dust_filters, :map
    field :expansion_slots, :map
    field :fan_options, :map
    field :included_psu, :string
    field :io, :map
    field :manufacturer, :string
    field :model, :string
    field :model_number, :string
    field :motherboard_support, {:array, :string}
    field :name, :string
    field :psu_mount_location, :string
    field :psu_shroud, :string
    field :psu_support, {:array, :string}
    field :radiator_support, :map
    field :release, :date
    field :type, :string
    field :weight, :decimal
    field :windows, :map

    timestamps()
  end

  @doc false
  def changeset(case, attrs) do
    case
    |> cast(attrs, [:name, :manufacturer, :model, :release, :model_number, :color, :type, :motherboard_support, :psu_support, :included_psu, :psu_shroud, :psu_mount_location, :windows, :dimensions, :clearance, :weight, :io, :dust_filters, :expansion_slots, :radiator_support, :fan_options])
    |> validate_required([:name, :manufacturer, :model, :release, :model_number, :color, :type, :motherboard_support, :psu_support, :included_psu, :psu_shroud, :psu_mount_location, :windows, :dimensions, :clearance, :weight, :io, :dust_filters, :expansion_slots, :radiator_support, :fan_options])
  end
end
