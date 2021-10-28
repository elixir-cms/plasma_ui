defmodule PlasmaUiWeb.Components.DataTable do
  @moduledoc """
  Takes a single prop, items, that is a list of enumerables in the form of maps or structs
  that are used as rows for each of the supplied column slots in a table.

  This particular version of what could become a more generic component contains a special
  conditional logic block that wraps the column content for the :source key in a live patch
  to the alter entity route used by PlasmaUiWeb.
  """

  use Surface.Component, slot: "cols"
  alias Surface.Components.LivePatch

  @doc "The list of items to be rendered"
  prop(items, :list, required: true)

  @doc "The list of columns defining the Table"
  slot(cols, args: [item: ^items])

  def ensure_map(val) do
    if Map.has_key?(val, :__struct__), do: Map.from_struct(val), else: val
  end

  def render(assigns) do
    ~F"""
    <table class="table is-bordered is-striped is-hoverable is-fullwidth">
      <thead>
        <tr>
          {#for col <- @cols}
            <th>
              {Phoenix.Naming.humanize(col.field)}
            </th>
          {/for}
        </tr>
      </thead>
      <tbody>
        {#for item <- @items}
          <tr>
            {#for column <- @cols, field = String.to_atom(column.field), item = ensure_map(item)}
              <td>
                {#if field == :label}
                  <LivePatch to={"/entity/" <> column.filter.(item[:source]) <> "/alter"}>
                    {column.filter.(item[field])}
                  </LivePatch>
                {#else}
                  {column.filter.(item[field])}
                {/if}
              </td>
            {/for}
          </tr>
        {/for}
      </tbody>
    </table>
    """
  end
end
