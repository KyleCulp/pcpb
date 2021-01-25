# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pcpb,
  ecto_repos: [Pcpb.Repo]

# Configures the endpoint
config :pcpb, PcpbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YPTtaS1hJbuzLf+Am1l80gjacz25T/5WW8wirMGHaFUYF4ZtyR+5i52TdT58mvyB",
  render_errors: [view: PcpbWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pcpb.PubSub,
  live_view: [signing_salt: "69GXt7zK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :pcpb, :pow,
  user: Pcpb.Users.User,
  repo: Pcpb.Repo,
  web_module: PcpbWeb,
  extensions: [PowResetPassword, PowPersistentSession],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: Pcpb.PowMailer,
  cache_store_backend: Pow.Store.Backend.MnesiaCache

config :nanoid,
  size: 8,
  alphabet: "0123456789abcdefghijklmnopqrstuvwxyz"

config :ex_aws,
  access_key_id: "miniokey",
  secret_access_key: "miniokey",
  # region: "us-west-2",
  json_codec: Jason,
  debug_requests: true

config :ex_aws, :s3,
  scheme: "http://",
  host: "localhost",
  port: 9000

config :pcpb,
  url: "http://localhost:9000/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
