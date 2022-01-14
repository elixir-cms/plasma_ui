defmodule PlasmaUiWeb.Entity.AlterTest do
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  @endpoint PlasmaUiWeb.Endpoint

  use ExUnit.Case, async: false
  use PlasmaUiWeb.ConnCase
  use Hound.Helpers
  @base "http://localhost:4002"

  alias EctoEntity.Type
  alias PlasmaUiWeb.Helpers.Store

  @test_type Type.new("test", "Test", "test", "tests")
             |> Type.migration_defaults!(fn set -> set end)

  hound_session()

  test "created test entity type, connected and mounted", %{conn: conn} do
    # Setup
    Store.put_type(@test_type)

    # Test
    assert Store.list_types() |> List.last() == "test"
    conn = get(conn, "/entity/test/alter")
    {:ok, _view, html} = live(conn)
    assert html =~ "<h2>Alter Entity - Test</h2>"

    # Teardown
    Store.remove_type("test")
  end

  test "updated test entity id field to be required" do
    # Setup
    Store.put_type(@test_type)

    # Test
    navigate_to("#{@base}/entity/test/alter")

    find_element(:css, "fieldset[name=\"entity[:fields]\"] .accordion:first-of-type .title")
    |> click()

    find_element(:css, "label[for=\"entity_fields_id_validation_options_required\"]") |> click()

    find_element(:id, "update-entity") |> click()

    {:ok, type} = Store.list_types() |> List.last() |> Store.get_type()

    assert type.fields["id"].validation_options.required

    # Teardown
    Store.remove_type("test")
  end

  test "added title field to test entity" do
    # Setup
    Store.put_type(@test_type)

    # Test
    navigate_to("#{@base}/entity/test/alter")

    find_element(:id, "add-field") |> click()

    find_element(:id, "new_field_field_name") |> fill_field("Title")

    find_element(:css, "form#new_field button[type=\"submit\"]") |> click()

    find_element(:id, "update-entity") |> click()

    {:ok, type} = Store.list_types() |> List.last() |> Store.get_type()

    assert Enum.member?(Map.keys(type.fields), "Title")

    # Teardown
    Store.remove_type("test")
  end
end
