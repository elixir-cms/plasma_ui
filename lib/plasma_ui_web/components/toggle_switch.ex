defmodule PlasmaUiWeb.Components.ToggleSwitch do
  @moduledoc """
  A toggle switch for boolean fields.
  """

  use Surface.Component

  @doc "The label to display above the switch"
  prop(label, :string)

  @doc "The current value to display"
  prop(value, :boolean, required: true)

  @doc "The event associated with a change"
  prop(changeEvent, :event, required: true)

  def render(assigns) do
    ~F"""
    <div class="toggle-switch flex">
      <label for={@label} class="flex cursor-pointer">
        <div class="relative">
          <input
            checked={@value}
            id={@label}
            type="checkbox"
            :on-click={@changeEvent} />
          <div class="inline-block toggle-path bg-grey w-16 h-9 rounded-full shadow-inner" tabindex="0" />
          <div class="toggle-circle absolute w-7 h-7 bg-white rounded-full shadow inset-y-0" />
          <div class="inline-block align-top pt-0 ml-2 font-light text-2xl">
            {#if @value}
              Yes
            {#else}
              No
            {/if}
          </div>
        </div>
      </label>
    </div>
    """
  end
end
