defmodule PlasmaUiWeb.Components.Form.EntityField do
  @moduledoc """
  A group of inputs used to managing each field on an entity.
  """

  use Surface.Component
  alias Surface.Components.Form.{Field, Label, TextInput, Select}

  prop name, :string, required: true

  def render(assigns) do
    ~H"""
    <Context get={{ entity: entity }}>
      <Label field="field_type" />
      <TextInput name={{ "entity[fields][#{@name}][field_type]" }}
                 value={{ entity.fields[@name].field_type }}
                 opts={{ placeholder: "Field type" }} />
      <Select
        name={{ "entity[fields][#{@name}][storage_type]" }}
        options={{ Binary: "binary", Boolean: "boolean" }}
        prompt="Storage type"
        selected={{ entity.fields[@name].storage_type }}
      />
    </Context>
    """
  end
end
