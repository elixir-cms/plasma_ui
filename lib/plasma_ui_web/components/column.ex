defmodule PlasmaUiWeb.Components.Column do
  use Surface.Component, slot: "cols"

  @doc "The field to be rendered"
  prop field, :string, required: true

  @doc "A function to filter the output of the field"
  prop filter, :fun, default: &Function.identity/1
end
