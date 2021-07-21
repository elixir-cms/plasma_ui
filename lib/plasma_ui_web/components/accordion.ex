defmodule PlasmaUiWeb.Components.Accordion do
  @moduledoc """
  TODO
  """

  use Surface.Component

  slot default, required: true

  prop title, :string, required: true

  def(render(assigns)) do
    ~F"""
    <div x-data="{ open: 0 }">
      <div @click="open = !open" class="accordion">
        <p>{@title}</p>
        <span :class="open == 1 ? 'fa-chevron-down' : 'fa-chevron-up'" class="fas" />
      </div>
      <div x-show="open == 1" class="border p-4">
        <#slot />
      </div>
    </div>
    """
  end
end
