use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :awcodify, AwcodifyWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :awcodify, Awcodify.Repo,
  username: System.get_env("TEST_DB_USERNAME"),
  password: System.get_env("TEST_DB_PASSWORD"),
  database: System.get_env("TEST_DB_NAME"),
  hostname: System.get_env("TEST_DB_HOST"),
  port: System.get_env("TEST_DB_PORT"),
  pool: Ecto.Adapters.SQL.Sandbox

# Configure comeonin to make it faster
config :bcrypt_elixir, log_rounds: 4
