defmodule Pcpb.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string
      # add :images, {:array, :string}, default: []
      add :images, :map
      add :images_thumbnail, {:array, :string}, default: []
      add :thumbnail, :string
      add :part_type, :string
      add :assigns, :map
      add :part_id, references(:parts, type: :string)

      timestamps()
    end

  end
end
