defmodule PlasmaUiWeb.Components.Form.NewField do
  @moduledoc """
  TODO
  """

  use Surface.Component
  alias Surface.Components.Form.{Label, Select, TextInput}

  prop(field, :map, required: true)

  def render(assigns) do
    ~F"""
    <fieldset class="border p-8" form="new_field" name="new_field">
      <legend>New Field</legend>
      <Label text="Field Name" />
      <TextInput
        id={"new_field_field_name"}
        name={"new_field[field_name]"}
        value={@field.field_name}
        opts={[placeholder: "Field name", required: true]}
      />
      <Label text="Field type" />
      <Select
        id={"new_field_field_type"}
        name={"new_field[field_type]"}
        options={Boolean: "boolean", "Naive Datetime": "naive_datetime", String: "string"}
        selected={@field.field_type}
      />
      <Label text="Storage type" />
      <Select
        id={"new_field_storage_type"}
        name={"new_field[storage_type]"}
        options={Boolean: "boolean", "Naive Datetime": "naive_datetime", String: "string"}
        selected={@field.storage_type}
      />
    </fieldset>
    """
  end
end
