defmodule PlasmaUiWeb.Components.DynamicField do
  @moduledoc """
  A component that dynamically displays different inputs based on field type.
  """

  use Surface.Component
  alias Surface.Components.Form.TextInput
  alias PlasmaUiWeb.Components.ToggleSwitch

  @doc "The field name"
  prop(name, :string, required: true)

  @doc "The type of field to display input for"
  prop(type, :string, required: true)

  @doc "The value of the field"
  prop(value, :any, required: true)

  def render(assigns) do
    ~F"""
    {#case @type}
      {#match "boolean"}
        <ToggleSwitch label={@name} value={@value} changeEvent={"#{Phoenix.Naming.underscore(@name)}_change"} />
      {#match "string"}
        <TextInput />
      {#match "naive_datetime"}
        datetime
      {#match _}
        Unrecognized field_type: "{@type}"
    {/case}
    """
  end
end
