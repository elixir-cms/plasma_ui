defmodule PlasmaUiWeb.PageLive do
  @moduledoc """
  A page for landing on.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.Accordion

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section>
      <Accordion title="Hello">
        <p>Fusce sagittis, libero non molestie mollis, magna orci ultrices dolor, at vulputate neque nulla lacinia eros.</p>
      </Accordion>
    </section>
    """
  end
end
