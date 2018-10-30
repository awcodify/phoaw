defmodule Awcodify.Repo do
  use Ecto.Repo,
    otp_app: :awcodify,
    adapter: Ecto.Adapters.Postgres
end
