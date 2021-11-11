defmodule PlasmaUiWeb.Components.AccordionTest do
  use Surface.LiveViewTest
  @endpoint PlasmaUiWeb.Endpoint

  use ExUnit.Case, async: true
  use Hound.Helpers
  @base "http://localhost:4002"

  alias PlasmaUiWeb.Components.Accordion
  alias Surface.Catalogue.Util

  hound_session()

  defp list_examples do
    {_, examples_and_playgrounds} = Util.get_components_info()

    for {_, component} <- examples_and_playgrounds, example <- component.examples, do: example
  end

  test "displayed title and slot content" do
    html =
      render_surface do
        ~F"""
        <Accordion title="Hello">World</Accordion>
        """
      end

    assert html =~ "<p>Hello</p>"
    assert html =~ "World"
  end

  test "included style attribute with contents of style prop" do
    html =
      render_surface do
        ~F"""
        <Accordion title="Hello" style="background:red">World</Accordion>
        """
      end

    assert html =~ "style=\"background: red\""
  end

  test "accordion title click displays content" do
    "#{@base}/catalogue/examples/Elixir.PlasmaUiWeb.Components.Accordion.Example01"
    |> navigate_to()

    find_element(:class, "accordion") |> find_within_element(:class, "title") |> click()

    assert find_element(:class, "accordion")
           |> find_within_element(:class, "content")
           |> css_property("display") == "block"
  end
end
