defmodule PlasmaUiWeb.Entity.List do
  @moduledoc """
  A liveview page that lists all existing entities.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.{Column, DataTable}
  alias PlasmaUiWeb.Helpers.Store

  def mount(_params, _session, socket) do
    entities =
      Enum.map(Store.list_types(), fn x ->
        {:ok, type} = Store.get_type(x)
        type
      end)

    {:ok, assign(socket, :entities, entities)}
  end

  def render(assigns) do
    ~F"""
    <section>
      <h2>Entities</h2>
      <article>
        <p>The table below shows a list of all available entities. Click on an entity title to alter it.</p>
        <DataTable items={@entities}>
          <Column field="label"><a href="/edit">Edit</a></Column>
          <Column field="source" />
          <Column field="singular" />
          <Column field="plural" />
        </DataTable>
      </article>
    </section>
    """
  end
end
