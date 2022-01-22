defmodule PlasmaUiWeb.Components.Alerts do
  @moduledoc """
  A simple component to show flash alerts.
  """

  use Surface.Component

  prop(flash, :any)

  def render(assigns) do
    ~F"""
      <p class="alert alert-info" role="alert" :on-click="lv:clear-flash" phx-value-key="info">{live_flash(@flash, :info)}</p>
      <p class="alert alert-danger" role="alert" :on-click="lv:clear-flash" phx-value-key="error">{live_flash(@flash, :error)}</p>
    """
  end
end
