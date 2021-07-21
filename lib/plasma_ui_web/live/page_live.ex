defmodule PlasmaUiWeb.PageLive do
  @moduledoc """
  A test page to land on.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.Modal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <section>
      <Modal>
        <#template slot="trigger">
          <div class="button">Add Field</div>
        </#template>
        <#template slot="content">
          <h3>Modals Are Easy!</h3>
          <p>Fusce sagittis, libero non molestie mollis, magna orci ultrices dolor, at vulputate neque nulla lacinia eros.</p>
          <br>
          <button onclick="alert('Hello World')">Greet Me</button>
        </#template>
      </Modal>
    </section>
    """
  end

  @impl true
  def handle_event("say_hello", _, socket) do
    IO.puts("Hello!")
    {:noreply, socket}
  end
end
