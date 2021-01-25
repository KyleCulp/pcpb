
defmodule Pcpb.App.Product do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :id}

  schema "products" do
    field :name, :string
    field :part_type, Ecto.Enum, values: Pcpb.Parts.Part.part_types
    field :assigns, :map
    # Array of user sorted images
    # field :images, {:array, :string}, default: []
    embeds_many :images, ImageMap, on_replace: :delete do
      field :full, :string
      field :thumbnail, :string
    end
    # field :images, :map
    # Thumbnail of first image, used for when mass showing products
    field :thumbnail, :string
    belongs_to :part, Pcpb.Parts.Part, type: :string

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :thumbnail, :part_id, :part_type, :assigns])
    |> validate_required([:name, :part_id, :part_type])
    |> foreign_key_constraint(:part)
    |> cast_assoc(:part, with: &Pcpb.Parts.Part.changeset/2)
    # |> Ecto.build_assoc(:images)
    |> cast_embed(:images, with: &images_map_changeset/2)
  end



def images_map_changeset(schema, params) do
  schema
  |> cast(params, [:id, :full, :thumbnail])
  |> validate_required([:id, :full])
end
end
