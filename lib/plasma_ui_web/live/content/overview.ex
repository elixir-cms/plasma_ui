defmodule PlasmaUiWeb.Content.Overview do
  @moduledoc """
  A liveview page that lists all entity types.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.Column
  alias PlasmaUiWeb.Components.DataTable
  alias PlasmaUiWeb.Components.Nav
  alias PlasmaUiWeb.Helpers.Store

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <article>
        <h3>Content</h3>
        <DataTable items={@entities} link_key={:label} path_prefix="content" path_param={:source}>
          <Column field="label" />
          <Column field="source" />
          <Column field="fields" field_filter={fn x -> x |> Map.keys() |> Enum.count() end} />
          <Column field="Entries" field_filter={fn _ -> :rand.uniform(20) end} />
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
