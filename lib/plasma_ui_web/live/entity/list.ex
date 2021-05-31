defmodule PlasmaUiWeb.Entity.List do
  @moduledoc """
  A liveview page that lists all existing entities.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.{Column, DataTable}
  alias PlasmaUiWeb.Helpers.Entity

  def mount(_params, _session, socket) do
    entities = Entity.get_entities()
    {:ok, assign(socket, :entities, entities)}
  end

  def render(assigns) do
    ~H"""
    <section>
      <h2>Entities</h2>
      <article>
        <p>The table below shows a list of all available entities. Click on an entity title to alter it.</p>
        <DataTable items={{ @entities }}>
          <Column field="label" />
          <Column field="archived" />
          <Column field="last_updated" filter={{ &PlasmaUiWeb.Helpers.DateTime.humanize_iso8601/1 }} />
        </DataTable>
      </article>
    </section>
    """
  end
end
