defmodule PlasmaUiWeb.Components.ToggleSwitch do
  @moduledoc """
  A toggle switch for boolean fields.
  """

  use Surface.Component

  @doc "The field name, shown as label and used as id"
  prop(fieldName, :string)

  @doc "The current value to display"
  prop(value, :boolean, required: true)

  @doc "The event associated with a change"
  prop(changeEvent, :event, required: true)

  def render(assigns) do
    ~F"""
    <div class="toggle-switch flex" phx-hook="ToggleSwitch">
      <label for={@fieldName} class="flex cursor-pointer">
        <div class="relative">
          <input checked={@value} id={@fieldName} type="checkbox" :on-click={@changeEvent}>
          <div class="inline-block toggle-path bg-grey w-9 h-5 rounded-full shadow-inner" tabindex="0" />
          <div class="toggle-circle absolute w-3.5 h-3.5 bg-white rounded-full shadow inset-y-0" />
          <div class="inline-block align-top leading-5 pt-0 ml-2 text-base">
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
