defmodule PlasmaUiWeb.Components.DynamicField do
  @moduledoc """
  A component that dynamically displays different inputs based on field type.
  """

  use Surface.Component
  alias Surface.Components.Form.TextInput
  alias PlasmaUiWeb.Components.DatePicker
  alias PlasmaUiWeb.Components.ToggleSwitch

  @doc "The field name"
  prop(fieldName, :string, required: true)

  @doc "The type of field to display input for"
  prop(fieldType, :string, required: true)

  @doc "The value of the field"
  prop(value, :any, required: true)

  def render(assigns) do
    ~F"""
    {#case @fieldType}
      {#match "boolean"}
        <ToggleSwitch
          changeEvent={@fieldName}
          fieldName={@fieldName}
          value={@value}
        />
      {#match "string"}
        <TextInput blur={@fieldName} opts={placeholder: "#{@fieldName |> Phoenix.Naming.humanize()}"} value={@value} />
      {#match "naive_datetime"}
        <DatePicker fieldName={"#{@fieldName}"} value={@value} />
      {#match _}
        <strong>Unrecognized field_type: "{@fieldType}"</strong>
    {/case}
    """
  end
end
