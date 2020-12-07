defmodule Pcpb.Repo.Migrations.CreateParts do
  use Ecto.Migration

  def change do
    create table(:parts) do
      add :name, :string
      add :partid, :integer

      timestamps()
    end
  end
end
