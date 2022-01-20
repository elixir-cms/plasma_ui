defmodule PlasmaUiWeb.Entity.List do
  @moduledoc """
  A liveview page that lists all existing entities.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.{Column, DataTable, Nav}
  alias PlasmaUiWeb.Helpers.Store
  alias Surface.Components.LivePatch

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <article>
        <h3 class="float-left">Entities</h3>
        <LivePatch class="button float-right" to="/entity/create">Create Entity</LivePatch>
        <DataTable
          items={@entities}
          link_key={:label}
          path_param={:source}
          path_prefix="entity"
          path_suffix="alter"
        >
          <Column field="label" field_filter={&Function.identity/1} />
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
