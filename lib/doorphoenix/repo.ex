defmodule Doorphoenix.Repo do
  use Ecto.Repo,
    otp_app: :doorphoenix,
    adapter: Ecto.Adapters.Postgres
end
