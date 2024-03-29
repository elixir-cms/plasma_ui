import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :plasma_ui, PlasmaUi.Repo,
  username: "postgres",
  password: "postgres",
  database: "plasma_ui_test#{System.get_env("MIX_TEST_PARTITION")}",
  socket_dir: "#{System.get_env("PGHOST")}",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :plasma_ui, PlasmaUiWeb.Endpoint,
  http: [port: 4002],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Hound
config :hound, driver: "chrome_driver", browser: "chrome_headless"
