# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ccb_api,
  ecto_repos: [CcbApi.Repo]

# Configures the endpoint
config :ccb_api, CcbApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v/wqzHit57lpiKa+PHYMwflJuif5+2IJML2RKYm6p7uz3qOm+AcKDFUwoR8anr86",
  render_errors: [view: CcbApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CcbApi.PubSub,
  live_view: [signing_salt: "rg1lNKmy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
