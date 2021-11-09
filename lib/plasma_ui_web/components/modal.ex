defmodule PlasmaUiWeb.Components.Modal do
  @moduledoc """
  A simple modal component with animated show/hide.
  """

  use Surface.Component

  slot(trigger, required: true)
  slot(content, required: true)

  def(render(assigns)) do
    ~F"""
    <div class="modal" @keydown.escape.window="showModal = false" x-data="{ 'showModal': false }">
      <div class="trigger" @click="showModal = true">
        <#slot name="trigger" />
      </div>
      <div class="content fixed flex inset-0 items-center justify-center min-h-screen" x-show="showModal">
        <div
          @click="showModal = false"
          class="overlay absolute bg-black bg-opacity-50 inset-0 z-40"
          x-show="showModal"
          x-transition:enter="transition ease-out duration-200"
          x-transition:enter-start="opacity-0"
          x-transition:enter-end="opacity-100"
          x-transition:leave="transition ease-in duration-200"
          x-transition:leave-start="opacity-100"
          x-transition:leave-end="opacity-0"
        />
        <div
          class="bg-white px-8 py-6 max-w-4xl md:min-w-1/2 rounded-2xl shadow-lg z-50"
          x-show="showModal"
          x-transition:enter="transition ease-out duration-300 delay-100"
          x-transition:enter-start="opacity-0 transform scale-90"
          x-transition:enter-end="opacity-100 transform scale-100"
          x-transition:leave="transition ease-in duration-300 delay-100"
          x-transition:leave-start="opacity-100 transform scale-100"
          x-transition:leave-end="opacity-0 transform scale-90"
        >
          <#slot name="content" />
        </div>
      </div>
    </div>
    """
  end
end
