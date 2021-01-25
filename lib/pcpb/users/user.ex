defmodule Pcpb.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema, extensions: [PowResetPassword, PowPersistentSession]

  schema "users" do
    pow_user_fields()
    field :username, :string
    field :admin, :boolean
    field :public, :boolean, default: true
    has_many :created_parts, Pcpb.Parts.Metadata
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> cast(attrs, [:admin, :username, :public])
    # |> validate_required([])
    # |> foreign_key_constraint(:part)
    # |> put_assoc(:part, %{id: attrs.part_id})
    # |> cast_assoc(:part, with: &Pcpb.Parts.Part.changeset/2)
  end
end
