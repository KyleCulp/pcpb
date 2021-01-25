defmodule Pcpb.Repo.Migrations.CreateParts do
  use Ecto.Migration

  def change do
    create table(:parts, primary_key: false) do
      add :id, :string, primary_key: true
      add :part_type, :string

      timestamps()
    end

  end
end
