use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoaw, PhoawWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoaw, Phoaw.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoaw_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure comeonin to make it faster
config :bcrypt_elixir, log_rounds: 4

import_config "dev.secret.exs"
