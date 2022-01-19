defmodule PlasmaUiWeb.Components.Column do
  use Surface.Component, slot: "columns"

  @moduledoc """
  A column component for use with the DataTable component.
  """

  @doc "The field to be rendered"
  prop(field, :string, required: true)

  @doc "A function to filter the output of the field"
  prop(field_filter, :fun, default: &Function.identity/1)

  @doc "A function to filter the output of the label"
  prop(label_filter, :fun, default: &Phoenix.Naming.humanize/1)
end
