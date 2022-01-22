defmodule PlasmaUiWeb.Components.Accordion do
  @moduledoc """
  A simple accordion. Props include title and style.
  Title is shown as the toggle text and style used as an attribute on the parent element.
  There is one slot, the default slot, which is used as accordion content.
  """

  use Surface.Component
  alias Phoenix.LiveView.JS

  slot(default, required: true)

  prop(style, :string, default: "")

  prop(title, :string, required: true)

  def(render(assigns)) do
    id = "accordion-" <> (System.unique_integer([:positive, :monotonic]) |> Integer.to_string())

    ~F"""
    <div class="accordion" id={id} style={@style} :hook="Accordion">
      <div class="trigger" :on-click={JS.dispatch("toggle", to: "##{id}")} tabindex="0">
        <p class="mb-0">{@title}</p>
        <span class="fas fa-chevron-down hidden" />
        <span class="fas fa-chevron-up" />
      </div>
      <div class="content hidden">
        <#slot />
      </div>
    </div>
    """
  end
end
