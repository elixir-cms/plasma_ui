defmodule PlasmaUiWeb.Content.List do
  @moduledoc """
  A liveview page that lists all entries of given entity type.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.{Column, DataTable, Nav}
  alias PlasmaUiWeb.Helpers.Store

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <article>
        <h3>{@entity.plural |> Phoenix.Naming.humanize()}</h3>
        <DataTable
          items={@entries}
          link_key={:label}
          path_param={:source}
          path_param_2={:id}
          path_prefix="content"
          path_suffix="edit"
        >
          <Column field="label" />
          <Column field="created_at" />
          <Column field="updated_at" />
        </DataTable>
      </article>
    </section>
    """
  end

  def mount(params, _session, socket) do
    {:ok, entity} = Store.get_type(params["source"])
    {:ok, example_datetime} = NaiveDateTime.new(2000, 1, 1, 0, 0, 0)
    String.to_atom("Entries")

    entries = [
      %{
        :label => "Hello World",
        :source => params["source"],
        :id => "123",
        :created_at => example_datetime,
        :updated_at => example_datetime
      },
      %{
        :label => "Another Exmaple",
        :source => params["source"],
        :id => "1234",
        :created_at => example_datetime,
        :updated_at => example_datetime
      }
    ]

    initial_socket =
      socket
      |> assign(:entries, entries)
      |> assign(:entity, entity)

    {:ok, initial_socket}
  end
end
