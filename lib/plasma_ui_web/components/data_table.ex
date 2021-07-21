defmodule PlasmaUiWeb.Components.DataTable do
  @moduledoc """
  TODO
  """

  use Surface.Component

  @doc "The list of items to be rendered"
  prop items, :list, required: true

  @doc "The list of columns defining the Table"
  slot cols

  def render(assigns) do
    ~F"""
    <table class="table is-bordered is-striped is-hoverable is-fullwidth">
      <thead>
        <tr>
          <th :for={col <- @cols}>
            {Phoenix.Naming.humanize(col.field)}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr :for={item <- @items} class={"is-selected": item[:selected]}>
          <td :for={col <- @cols, field = String.to_atom(col.field)}>
            {col.filter.(item[field])}
          </td>
        </tr>
      </tbody>
    </table>
    """
  end
end
