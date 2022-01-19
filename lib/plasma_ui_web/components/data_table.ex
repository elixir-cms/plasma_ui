defmodule PlasmaUiWeb.Components.DataTable do
  @moduledoc """
  Takes a single prop, items, that is a list of enumerables in the form of maps or structs
  that are used as rows for each of the supplied column slots in a table.

  This particular version of what could become a more generic component contains a special
  conditional logic block that wraps the column content for the :source key in a live patch
  to the alter entity route used by PlasmaUiWeb.
  """

  use Surface.Component, slot: "columns"
  alias Surface.Components.LivePatch

  @doc "The list of items to be rendered"
  prop(items, :list, required: true)

  @doc "A key to use for linking each item"
  prop(link_key, :atom, required: true)

  @doc "A string to use as the prefix for the linked path"
  prop(path_prefix, :string, required: true)

  @doc "An atom to use for the path param after the linked path prefix"
  prop(path_param, :atom, required: true)

  @doc "An atom to *maybe* use for a second path param"
  prop(path_param_2, :atom)

  @doc "A string to *maybe* use as the suffix for the linked path"
  prop(path_suffix, :string)

  @doc "The list of columns defining the table"
  slot(columns, args: [item: ^items])

  def ensure_map(val) do
    if Map.has_key?(val, :__struct__), do: Map.from_struct(val), else: val
  end

  def maybe_path_param(param, item) do
    if is_nil(param) do
      ""
    else
      "/" <> item[param]
    end
  end

  def maybe_path_suffix(suffix) do
    if is_nil(suffix) do
      ""
    else
      "/" <> suffix
    end
  end

  def render(assigns) do
    ~F"""
    <table class="table is-bordered is-striped is-hoverable is-fullwidth">
      <thead>
        <tr>
          {#for column <- @columns}
            <th>
              {column.label_filter.(column.field)}
            </th>
          {/for}
        </tr>
      </thead>
      <tbody>
        {#for item <- @items}
          <tr>
            {#for column <- @columns, field = String.to_atom(column.field), item = ensure_map(item)}
              <td>
                {#if field == @link_key}
                  <LivePatch to={"/" <>
                    @path_prefix <>
                    "/" <>
                    item[@path_param] <> maybe_path_param(@path_param_2, item) <> maybe_path_suffix(@path_suffix)}>
                    {column.field_filter.(item[field])}
                  </LivePatch>
                {#else}
                  {column.field_filter.(item[field])}
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
