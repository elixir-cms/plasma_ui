defmodule PlasmaUiWeb.Components.Input.TextInput do
  @moduledoc """
  Defines a text **input** that lets the user input text.

  """

  use Surface.Component
  require Logger

  @doc "The element ID to use for the text input."
  prop id, :string, default: "text-input"

  @doc "Placeholder text to show for the text input."
  prop placeholder, :string

  @doc "The keydown event for the text input runs when the user presses a key."
  prop keydown, :event

  @doc "The keyup event for the text input runs when the user releases a key."
  prop keyup, :event

  def render(assigns) do
    ~H"""
    <input
      type="text"
      id={{@id}}
      placeholder={{@placeholder}}
      :on-keydown={{@keydown}}
      :on-keyup={{@keyup}}
    />
    """
  end
end
