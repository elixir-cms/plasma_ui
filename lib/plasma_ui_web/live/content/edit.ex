defmodule PlasmaUiWeb.Content.Edit do
  @moduledoc """
  A liveview page provides a content editing interface for individual entries of any entity type.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.DynamicField
  alias PlasmaUiWeb.Components.Nav
  alias PlasmaUiWeb.Helpers.Store

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <article>
        <h2>{@entity.plural |> Phoenix.Naming.humanize()}</h2>
        <div class="mb-4" :for={key <- Map.keys(@entity.fields)} }>
          <label>{key |> Phoenix.Naming.humanize()}</label>
          <DynamicField name={key} type={@entity.fields[key].field_type} value={@entry.example} />
        </div>
      </article>
    </section>
    """
  end

  def mount(params, _session, socket) do
    {:ok, entity} = Store.get_type(params["source"])
    entry = %{example: true}

    initial_socket =
      socket
      |> assign(:entity, entity)
      |> assign(:entry, entry)

    {:ok, initial_socket}
  end

  def handle_event(change_name, value, socket) do
    IO.inspect(change_name)
    IO.inspect(value)
    {:noreply, socket}
  end
end
