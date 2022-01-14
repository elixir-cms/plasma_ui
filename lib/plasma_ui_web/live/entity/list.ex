defmodule PlasmaUiWeb.Entity.List do
  @moduledoc """
  A liveview page that lists all existing entities.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.{Column, DataTable, Nav}
  alias PlasmaUiWeb.Helpers.Store

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <article>
        <h2>Entities</h2>
        <DataTable items={@entities}>
          <Column field="label" />
          <Column field="source" />
          <Column field="singular" />
          <Column field="plural" />
        </DataTable>
      </article>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    entities =
      Enum.map(Store.list_types(), fn x ->
        {:ok, type} = Store.get_type(x)
        type
      end)

    {:ok, assign(socket, :entities, entities)}
  end
end
