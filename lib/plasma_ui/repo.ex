defmodule PlasmaUi.Repo do
  use Ecto.Repo,
    otp_app: :plasma_ui,
    adapter: Ecto.Adapters.Postgres
end
