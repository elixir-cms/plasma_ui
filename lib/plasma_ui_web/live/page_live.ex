defmodule PlasmaUiWeb.PageLive do
  @moduledoc """
  A test page to land on.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.Modal
  alias Surface.Components.LivePatch

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <section>
      <LivePatch to="/entity/list">
        <div class="button">List Entities</div>
      </LivePatch>
      <LivePatch to="/entity/create">
        <div class="button">Create Entity</div>
      </LivePatch>
      <LivePatch to="/entity/alter">
        <div class="button">Alter Entity</div>
      </LivePatch>
    </section>
    """
  end

  @impl true
  def handle_event("say_hello", _, socket) do
    IO.puts("Hello!")
    {:noreply, socket}
  end
end
