defmodule PlasmaUiWeb.Entity.AlterTest do
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  @endpoint PlasmaUiWeb.Endpoint

  use ExUnit.Case, async: false
  use PlasmaUiWeb.ConnCase

  alias EctoEntity.Type
  alias PlasmaUiWeb.Helpers.Store

  test "created test entity type, connected and mounted", %{conn: conn} do
    # Setup
    Type.new("test", "Test", "test", "tests")
    |> Type.migration_defaults!(fn set -> set end)
    |> Store.put_type()

    # Test
    assert Store.list_types() |> List.last() == "test"
    conn = get(conn, "/entity/test/alter")
    {:ok, _view, html} = live(conn)
    assert html =~ "<h2>Alter Entity - Test</h2>"

    # Teardown
    Store.remove_type("test")
  end
end
