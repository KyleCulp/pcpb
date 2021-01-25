defmodule Pcpb.Repo.Migrations.CreateMetadatas do
  use Ecto.Migration

  def change do
    create table(:metadatas) do
      add :edits, {:array, :map}
      add :part_id, references(:parts, on_delete: :nothing, type: :string)
      # add :created_by, references(:users, on_delete: :nothing, type: :string)

      timestamps()
    end

    create index(:metadatas, [:part_id])
    # create index(:metadatas, [:created_by])
  end
end
