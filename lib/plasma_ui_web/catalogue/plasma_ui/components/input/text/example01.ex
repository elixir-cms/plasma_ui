defmodule PlasmaUiWeb.Components.Input.TextInput.Example01 do
  use Surface.Catalogue.Example,
    catalogue: Surface.Components.Catalogue,
    subject: PlasmaUiWeb.Components.Input.TextInput,
    height: "100px"

  def render(assigns) do
    ~H"""
    <TextInput
      id="text-input"
      placeholder="Example placeholder"
    />
    """
  end
end
