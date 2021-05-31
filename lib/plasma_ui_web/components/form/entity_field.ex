defmodule PlasmaUiWeb.Components.Form.EntityField do
  @moduledoc """
  A group of inputs used for managing each field on an entity.
  """

  use Surface.Component
  alias PlasmaUiWeb.Components.Accordion
  alias Surface.Components.Form.{Label, TextInput, Select}
  alias PlasmaUiWeb.Components.Form.{PersistenceOptions, ValidationOptions}

  prop name, :string, required: true

  prop field, :map, required: true

  def render(assigns) do
    ~H"""
    <fieldset form="entity" name={{ "entity[fields][#{@name}]" }}>
      <legend>{{ Phoenix.HTML.Form.humanize(@name) }}</legend>
      <Label text="Field type" />
      <TextInput
        id={{ "entity_fields_#{@name}_field_type" }}
        name={{ "entity[fields][#{@name}][field_type]" }}
        value={{ @field.field_type }}
        opts={{ placeholder: "Field type" }}
      />
      <Label text="Storage type" />
      <Select
        id={{ "entity_fields_#{@name}_storage_type" }}
        name={{ "entity[fields][#{@name}][storage_type]" }}
        options={{ Binary: "binary", Boolean: "boolean" }}
        prompt="Storage type"
        selected={{ @field.storage_type }}
      />
      <Accordion title="Persistence options">
        <PersistenceOptions parent_name={{ @name }} options={{ @field.persistence_options }} />
      </Accordion>
      <Accordion title="Validation options">
        <ValidationOptions parent_name={{ @name }} options={{ @field.validation_options }} />
      </Accordion>
    </fieldset>
    """
  end
end
