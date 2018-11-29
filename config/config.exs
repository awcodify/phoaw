# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoaw,
  ecto_repos: [Phoaw.Repo]

# Configures the endpoint
config :phoaw, PhoawWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5EBILhaUgBZEKDO1Lk25UyAZKfHMj7f9RuFEBj6Q/CBLC+FUEbxCrmpADQPLyJvG",
  render_errors: [view: PhoawWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Phoaw.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Guardian
config :phoaw, Phoaw.Auth.Guardian,
  issuer: "phoaw",
  secret_key: "2n6mwHyW6EH71cRWyfvgZqzLLBpR18u02uErCOnSLqZmfg86OwZl036QkoU1Ezhl"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
