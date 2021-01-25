defmodule Pcpb.Parts.GPU do
  use Ecto.Schema
  import Ecto.Changeset
  use Pcpb.Parts.Base
  import Pcpb.Parts.Base

  schema "gpus" do
    part_base_fields()
    dimensions_map()

    field :series, :string
    field :chipset, :string
    field :interface, :string
    field :directx, :string
    field :opengl, :string
    field :cuda_cores, :integer
    field :stream_processors, :integer
    field :core_clock, :decimal
    field :boost_clock, :decimal

    field :memory, :string
    field :memory_clock, :string
    field :memory_type, :string
    field :memory_interface, :string
    field :sli_support, :string
    field :crossfire_support, :string
    field :frame_sync, :string
    field :slot_width, :string
    field :max_resolution, :string
    field :max_monitors, :integer
    field :power_connector, :string
    field :ray_tracing, :string
    field :cooler, :string
    field :hdcp, :string
    field :backplate, :string
    field :io, {:array, :string}
    field :rgb, :string
    field :color, :string
    field :tdp, :decimal
    field :weight, :decimal

    timestamps()
  end

  @doc false
  def changeset(gpu, attrs) do
    gpu
    |> part_base_fields_changeset(attrs)
    |> cast_embed(:dimensions, with: &dimensions_map_changeset/2, force_update_on_change: true)
    |> cast(attrs, [
      :series,
      :chipset,
      :interface,
      :directx,
      :opengl,
      :cuda_cores,
      :stream_processors,
      :core_clock,
      :boost_clock,
      :memory,
      :memory_clock,
      :memory_interface,
      :memory_type,
      :sli_support,
      :crossfire_support,
      :frame_sync,
      :slot_width,
      :max_resolution,
      :max_monitors,
      :power_connector,
      :ray_tracing,
      :cooler,
      :hdcp,
      :backplate,
      :io,
      :rgb,
      :tdp,
      :weight,
      :color
    ])
    |> validate_required([
      :series,
      :chipset,
      :interface,
      :directx,
      :opengl,
      :cuda_cores,
      :stream_processors,
      :core_clock,
      :boost_clock,
      :memory,
      :memory_clock,
      :memory_interface,
      :memory_type,
      :sli_support,
      :crossfire_support,
      :frame_sync,
      :slot_width,
      :max_resolution,
      :max_monitors,
      :power_connector,
      :ray_tracing,
      :cooler,
      :hdcp,
      :backplate,
      :io,
      :rgb
    ])
  end
end
