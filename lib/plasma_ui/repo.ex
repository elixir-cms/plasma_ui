defmodule PlasmaUi.Repo do
  use Ecto.Repo,
    otp_app: :plasma_ui,
    adapter: Ecto.Adapters.Postgres

  @dialyzer {:nowarn_function, rollback: 1}
end
