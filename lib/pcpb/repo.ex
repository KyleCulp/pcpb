defmodule Pcpb.Repo do
  use Ecto.Repo,
    otp_app: :pcpb,
    adapter: Ecto.Adapters.Postgres
end
