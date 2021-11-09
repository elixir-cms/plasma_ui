defmodule PlasmaUiWeb.Components.Accordion.Example01 do
  @moduledoc """
  A surface catalogue example component for PlasmaUiWeb.Components.Accordion.
  """

  use Surface.Catalogue.Example,
    catalogue: PlasmaUiWeb.Components.Catalogue,
    subject: PlasmaUiWeb.Components.Accordion,
    height: "170px"

  def render(assigns) do
    ~F"""
    <Accordion title="Hello">World</Accordion>
    """
  end
end
