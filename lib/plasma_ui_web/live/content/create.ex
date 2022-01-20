defmodule PlasmaUiWeb.Content.Create do
  @moduledoc """
  A liveview page that provides an interface for creating new content for a given entity type.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.Nav
  alias PlasmaUiWeb.Helpers.Store

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <article>
        <h3>Create {@entity.singular |> Phoenix.Naming.humanize()}</h3>
      </article>
    </section>
    """
  end

  def mount(params, _session, socket) do
    {:ok, entity} = Store.get_type(params["source"])

    initial_socket =
      socket
      |> assign(:entity, entity)

    {:ok, initial_socket}
  end
end
