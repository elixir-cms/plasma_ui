defmodule PlasmaUiWeb.Components.AccordionTest do
  use Surface.LiveViewTest
  @endpoint PlasmaUiWeb.Endpoint

  use ExUnit.Case, async: true
  use Hound.Helpers
  @base "http://localhost:4002"

  alias PlasmaUiWeb.Components.Accordion
  alias Surface.Catalogue.Util
  @base_url "http://localhost.test:4002/catalogue/examples/"

  hound_session()

  defp list_examples do
    {_, examples_and_playgrounds} = Util.get_components_info()

    for {_, component} <- examples_and_playgrounds, example <- component.examples, do: example
  end

  def example_url(module, opts) do
    base_url = Keyword.fetch!(opts, :base_url) |> URI.parse()
    path = Path.join(base_url.path, to_string(module))
    %URI{base_url | path: path}
  end

  def get_example_refs(opts) do
    list_examples()
    |> Enum.map(fn example ->
      example
      |> example_url(opts)
      |> IO.inspect(opts)
    end)
  end

  test "displayed title and slot content" do
    html =
      render_surface do
        ~F"""
        <Accordion title="Hello">World</Accordion>
        """
      end

    get_example_refs(base_url: @base_url)

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
