defmodule Pcpb.Repo.Migrations.CreateMemorys do
  use Ecto.Migration
  import Pcpb.Parts.Base

  def change do
    create table(:memorys, primary_key: false) do
      part_base_fields_migration

      add :series, :string
      add :color, :string
      add :led, :string
      add :type, :string
      add :chipset, :string
      add :module_size, :string
      add :speed, :string
      add :speeed_rating, :string
      add :cas_latency, :integer
      add :voltage, :string
      add :timing, :string
      add :heatsink, :string
      add :ecc, :string
      add :ecc_rank, :string

      timestamps()
    end

  end
end
