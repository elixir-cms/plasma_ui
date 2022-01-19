defmodule PlasmaUiWeb.Components.Form.PersistenceOptions do
  @moduledoc """
  A group of inputs used to managing persistence options.
  """

  use Surface.Component
  alias Surface.Components.Form.{Label, TextInput, Checkbox}
  alias PlasmaUiWeb.Helpers.Entity, as: EntityHelper

  prop(parent_name, :string, required: true)

  prop(options, :map, required: true)

  def render(assigns) do
    ~F"""
    <fieldset form="entity" name={"entity[fields][#{@parent_name}][persistence_options]"}>
      <legend>Persistence options</legend>
      <Checkbox
        id={"entity_fields_#{@parent_name}_persistence_options_primary_key"}
        name={"entity[fields][#{@parent_name}][persistence_options][primary_key]"}
        opts={[
          phx_blur: "blur",
          phx_value_fieldname: "#{@parent_name}",
          phx_value_key: "persistence_options",
          phx_value_subkey: "primary_key"
        ]}
        value={EntityHelper.map_value?(@options, :primary_key)}
      />
      <Label field={"fields_#{@parent_name}_persistence_options_primary_key"} text="Primary key" />
      <br>
      <Checkbox
        id={"entity_fields_#{@parent_name}_persistence_options_nullable"}
        name={"entity[fields][#{@parent_name}][persistence_options][nullable]"}
        opts={[
          phx_blur: "blur",
          phx_value_fieldname: "#{@parent_name}",
          phx_value_key: "persistence_options",
          phx_value_subkey: "nullable"
        ]}
        value={@options.nullable}
      />
      <Label field={"fields_#{@parent_name}_persistence_options_nullable"} text="Nullable" />
      <br>
      <Checkbox
        id={"entity_fields_#{@parent_name}_persistence_options_unique"}
        name={"entity[fields][#{@parent_name}][persistence_options][unique]"}
        opts={[
          phx_blur: "blur",
          phx_value_fieldname: "#{@parent_name}",
          phx_value_key: "persistence_options",
          phx_value_subkey: "unique"
        ]}
        value={EntityHelper.map_value?(@options, :unique)}
      />
      <Label field={"fields_#{@parent_name}_persistence_options_unique"} text="Unique" />
      <br>
      <Label text="Default" />
      <TextInput
        id={"entity_fields_#{@parent_name}_persistence_options_default"}
        name={"entity[fields][#{@parent_name}][persistence_options][default]"}
        opts={[
          phx_blur: "blur",
          phx_value_fieldname: "#{@parent_name}",
          phx_value_key: "persistence_options",
          phx_value_subkey: "default"
        ]}
        value={EntityHelper.map_value?(@options, :default)}
      />
    </fieldset>
    """
  end
end
