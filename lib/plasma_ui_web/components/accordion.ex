defmodule PlasmaUiWeb.Components.Accordion do
  @moduledoc """
  A simple accordion. Props include title and style.
  Title is shown as the toggle text and style used as an attribute on the parent element.
  There is one slot, the default slot, which is used as accordion content.
  """

  use Surface.Component

  slot(default, required: true)

  prop(style, :string, default: "")

  prop(title, :string, required: true)

  def(render(assigns)) do
    ~F"""
    <div class="accordion" style={@style} x-data="{ open: 0 }">
      <div @click="open = !open" class="title">
        <p>{@title}</p>
        <span :class="open == 1 ? 'fa-chevron-down' : 'fa-chevron-up'" class="fas" />
      </div>
      <div class="content border p-4" x-show="open == 1">
        <#slot />
      </div>
    </div>
    """
  end
end
