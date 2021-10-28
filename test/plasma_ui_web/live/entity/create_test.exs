defmodule PlasmaUiWeb.Entity.CreateTest do
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  @endpoint PlasmaUiWeb.Endpoint

  use ExUnit.Case, async: true
  use PlasmaUiWeb.ConnCase

  alias PlasmaUiWeb.Helpers.Store

  test "connected and mounted", %{conn: conn} do
    conn = get(conn, "/entity/create")
    {:ok, _view, html} = live(conn)
    assert html =~ "<h2>Create Entity</h2>"
  end

  test "entity field inputs are correct", %{conn: conn} do
    conn = get(conn, "/entity/create")
    {:ok, view, _html} = live(conn)
    assert view |> has_element?("input#entity_label")
    assert view |> has_element?("input#entity_source")
    assert view |> has_element?("input#entity_singular")
    assert view |> has_element?("input#entity_plural")
  end

  test "form submit created new entity and redirected to /", %{conn: conn} do
    conn = get(conn, "/entity/create")
    {:ok, view, _html} = live(conn)

    view
    |> element("form#entity")
    |> render_submit(%{
      "entity" => %{
        "source" => "test",
        "label" => "Test",
        "singular" => "test",
        "plural" => "tests"
      }
    })

    assert_redirect(view, "/", 30)
    assert Store.list_types() |> List.last() == "test"
    Store.remove_type("test")
  end
end
