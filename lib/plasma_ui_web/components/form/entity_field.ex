defmodule PlasmaUiWeb.Components.Form.EntityField do
  @moduledoc """
  A group of inputs used for managing each field on an entity.
  """

  use Surface.Component
  alias PlasmaUiWeb.Components.Accordion
  alias Surface.Components.Form.{Checkbox, Label, TextInput, Select}
  alias PlasmaUiWeb.Components.Form.{PersistenceOptions, ValidationOptions}
  alias PlasmaUiWeb.Helpers.Entity, as: EntityHelper

  prop(name, :string, required: true)

  prop(field, :map, required: true)

  def render(assigns) do
    ~F"""
    <fieldset form="entity" name={"entity[fields][#{@name}]"}>
      <legend>{Phoenix.HTML.Form.humanize(@name)}</legend>
      <Label text="Field type" />
      <TextInput
        id={"entity_fields_#{@name}_field_type"}
        name={"entity[fields][#{@name}][field_type]"}
        opts={[readonly: true, placeholder: "Field type"]}
        value={@field.field_type}
      />
      <Label text="Storage type" />
      <Select
        id={"entity_fields_#{@name}_storage_type"}
        name={"entity[fields][#{@name}][storage_type]"}
        options={Boolean: "boolean", "Naive Datetime": "naive_datetime", String: "string"}
        opts={[readonly: true, tabindex: -1]}
        prompt="Storage type"
        selected={@field.storage_type}
      />
      <Label text="Standard Options" />
      <Checkbox
        id={"entity_fields_#{@name}_validation_options_required"}
        name={"entity[fields][#{@name}][validation_options][required]"}
        opts={[phx_blur: "blur", phx_value_field: "#{@name}", phx_value_option: "validation_options_required"]}
        value={if @field.validation_options == %{}, do: false, else: @field.validation_options.required}
      />
      <Label field={"fields_#{@name}_validation_options_required"} text="Required Field" />
      <br>
      <Checkbox
        id={"entity_fields_#{@name}_persistence_options_indexed"}
        name={"entity[fields][#{@name}][persistence_options][indexed]"}
        opts={[phx_blur: "blur", phx_value_field: "#{@name}", phx_value_option: "persistence_options_indexed"]}
        value={EntityHelper.map_value?(@field.persistence_options, :indexed)}
      />
      <Label field={"fields_#{@name}_persistence_options_indexed"} text="Enable Sorting & Filtering" />
      <Label text="Advanced Options" />
      <Accordion title="Persistence options">
        <PersistenceOptions parent_name={@name} options={@field.persistence_options} />
      </Accordion>
      <Accordion title="Validation options">
        <ValidationOptions parent_name={@name} options={@field.validation_options} />
      </Accordion>
      <Accordion title="More" style="display: none;">
        <Label text="Filters" />
        <fieldset form="entity" name={"entity[fields][#{@name}][filters]"}>
          <TextInput
            id={"entity_fields_#{@name}_filters"}
            name={"entity[fields][#{@name}][filters]"}
            opts={[phx_blur: "blur", phx_value_field: "#{@name}", phx_value_option: "filters", placeholder: "Filters"]}
            value={@field.filters}
          />
        </fieldset>
        <Label text="Meta" />
        <fieldset form="entity" name={"entity[fields][#{@name}][meta]"}>
          {#for key <- Map.keys(@field.meta)}
            <fieldset form="entity" name={"entity[fields][#{@name}][meta][#{key}]"}>
              <legend>{Phoenix.HTML.Form.humanize(key)}</legend>
              {#for key2 <- Map.keys(@field.meta[key])}
                <Label text={Phoenix.HTML.Form.humanize(key2)} />
                <TextInput
                  id={"entity_fields_#{@name}_meta_#{key}_#{key2}"}
                  name={"entity[fields][#{@name}][meta][#{key}][#{key2}]"}
                  opts={[phx_blur: "blur", phx_value_field: "#{@name}", phx_value_option: "#{key}", placeholder: key2]}
                  value={@field.meta[key][key2]}
                />
              {/for}
            </fieldset>
          {/for}
        </fieldset>
      </Accordion>
    </fieldset>
    """
  end
end
