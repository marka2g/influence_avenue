defmodule InfluenceAvenue.Repo do
  use Ecto.Repo,
    otp_app: :influence_avenue,
    adapter: Ecto.Adapters.Postgres
end
