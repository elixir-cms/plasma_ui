defmodule PlasmaUiWeb.Components.DatePicker do
  use Surface.Component

  @moduledoc """
  A column component for use with the DataTable component.
  """

  @doc "A the field name to use as the id for the component"
  prop(fieldName, :string, required: true)

  @doc "The current value to display"
  prop(value, :naive_datetime, required: true)

  def render(assigns) do
    ~F"""
    <div class="date-picker" id={"{@fieldName}-picker"} phx-hook="DatePicker">
      <svg class="calendar-icon w-6 h-6" fill="black" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
      <input
        class="mb-2 pl-8 rounded w-full sibling"
        placeholder="Select Date"
        id={@fieldName}
        readonly
        tabindex="0"
        type="text"
        value={@value}>
      <input
        class="flatpickr"
        default-date={@value}
        phx-update="ignore"
        type="text">
    </div>
    """
  end
end
