config :phoaw, Phoaw.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoaw_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
