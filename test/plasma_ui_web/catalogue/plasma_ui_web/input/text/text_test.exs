defmodule PlasmaUiWeb.ComponentInputTextTest do
  use PlasmaUiWeb.ConnCase

  import Phoenix.LiveViewTest

  test "Surface Catalog example loads text input element", %{conn: conn} do
    route = "/catalogue/examples/PlasmaUiWeb.Components.Input.TextInput.Example01"
    {:ok, view, _html} = live(conn, route)

    view
    |> element("#text-input")
    |> has_element?()
  end
end
