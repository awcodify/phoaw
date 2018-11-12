defmodule Phoaw.Repo do
  use Ecto.Repo,
    otp_app: :phoaw,
    adapter: Ecto.Adapters.Postgres
end
