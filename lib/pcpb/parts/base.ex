defmodule Pcpb.Parts.Base do
  use Ecto.Migration
  use Ecto.Schema
  import Ecto.Changeset

  defmacro __using__(_) do
    quote do
      import Ecto.Schema, only: [schema: 2, embedded_schema: 1]
      @primary_key {:id, :string, autogenerate: false}
      @derive {Phoenix.Param, key: :id}
    end
  end

  @doc """
  A macro to add fields from the `@pow_fields` module attribute generated in
  `__using__/1`.
  The `@pow_fields` are populated by `Pow.Ecto.Schema.Fields.attrs/1`, and will
  have at minimum the following fields:
    * `:email` (if not changed with `:user_id_field` option)
    * `:password_hash`
    * `:current_password` (virtual)
    * `:password` (virtual)
  """
  defmacro part_base_fields do
    quote do
      field :name, :string
      field :manufacturer, :string
      field :model, :string
      field :model_number, :string
      field :launch, :date
    end
  end

  defmacro dimensions_map do
    quote do
      embeds_one :dimensions, DimensionsMap do
        field :length, :decimal
        field :width, :decimal
        field :height, :decimal
      end
    end
  end

  def part_base_fields_changeset(changeset, params) do
    changeset
    |> cast(params, [
      :id,
      :name,
      :manufacturer,
      :model,
      :model_number,
      :launch
    ])
    |> validate_required([
      :name,
      :manufacturer,
      :model,
      :model_number,
      :launch
    ])

    # |> Map.merge(%{id: generate_product_id})

    # |> cast_embed(:dimensions, with: &dimensions_map_changeset/2)
  end

  def dimensions_map_changeset(schema, params) do
    schema
    |> cast(params, [:length, :width, :height])
    |> validate_required([
      :length,
      :width,
      :height
    ])
  end

  defmacro part_base_fields_migration do
    quote do
      add(:id, :string, primary_key: true)
      add(:name, :string)
      add(:manufacturer, :string)
      add(:model, :string)
      add(:model_number, :string)
      add(:launch, :date)
    end
  end
end
