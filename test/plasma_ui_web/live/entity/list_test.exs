defmodule PlasmaUiWeb.Entity.ListTest do
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  @endpoint PlasmaUiWeb.Endpoint

  use ExUnit.Case, async: true
  use PlasmaUiWeb.ConnCase

  alias PlasmaUiWeb.Helpers.Store

  test "connected and mounted", %{conn: conn} do
    conn = get(conn, "/")
    {:ok, _view, html} = live(conn)
    assert html =~ "<h2>Entities</h2>"
  end

  test "loaded table with row for each entity in the Store", %{conn: conn} do
    conn = get(conn, "/")
    {:ok, view, _html} = live(conn)
    assert view |> has_element?("table")
    assert view |> has_element?("tbody > tr:nth-of-type(#{Enum.count(Store.list_types())})")
  end

  test "table included the correct 4 columns for entities", %{conn: conn} do
    conn = get(conn, "/")
    {:ok, view, _html} = live(conn)
    assert view |> has_element?("table")
    assert view |> element("th:nth-of-type(1)", ~r/Label/) |> has_element?()
    assert view |> element("th:nth-of-type(2)", ~r/Source/) |> has_element?()
    assert view |> element("th:nth-of-type(3)", ~r/Singular/) |> has_element?()
    assert view |> element("th:nth-of-type(4)", ~r/Plural/) |> has_element?()
  end

  test "row labels are live patched to entity alter views", %{conn: conn} do
    {:ok, view, _html} = conn |> get("/") |> live()
    [first_name | _] = Store.list_types()
    first_path = "/entity/#{first_name}/alter"
    first_link = element(view, "tbody > tr:first-child a")
    first_link |> render_click()
    view |> assert_patch(first_path)
  end
end
