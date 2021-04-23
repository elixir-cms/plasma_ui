defmodule PlasmaUiWeb.Components.Input.TextInput.Playground do
  use Surface.Catalogue.Playground,
    catalogue: Surface.Components.Catalogue,
    subject: PlasmaUiWeb.Components.Input.TextInput,
    height: "100px"

  data props, :map,
    default: %{
      id: "text-input",
      placeholder: "The placeholder's content"
    }

  def render(assigns) do
    ~H"""
    <TextInput :props={{ @props }}/>
    """
  end
end
