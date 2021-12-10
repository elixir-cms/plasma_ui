defmodule PlasmaUiWeb.Components.Form.ValidationOptions do
  @moduledoc """
  A group of inputs used to managing validation options.
  """

  use Surface.Component
  alias Surface.Components.Form.{Label, NumberInput, TextInput}
  alias PlasmaUiWeb.Helpers.Entity, as: EntityHelper

  prop(parent_name, :string, required: true)

  prop(options, :map, required: true)

  def render(assigns) do
    ~F"""
    <fieldset form="entity" name={"entity[fields][#{@parent_name}][validation_options]"}>
      <legend>Validation options</legend>
      <Label field={"fields_#{@parent_name}_validation_options_format"} text="Format" />
      <TextInput
        id={"entity_fields_#{@parent_name}_validation_options_format"}
        name={"entity[fields][#{@parent_name}][validation_options][format]"}
        opts={[phx_blur: "blur", phx_value_field: "#{@parent_name}", phx_value_option: "validation_options_format"]}
        value={EntityHelper.map_value?(@options, :format)}
      />
      <Label field={"fields_#{@parent_name}_validation_options_number"} text="Number" />
      <NumberInput
        id={"entity_fields_#{@parent_name}_validation_options_number"}
        name={"entity[fields][#{@parent_name}][validation_options][number]"}
        opts={[phx_blur: "blur", phx_value_field: "#{@parent_name}", phx_value_option: "validation_options_number"]}
        value={EntityHelper.map_value?(@options, :number)}
      />
      <Label field={"fields_#{@parent_name}_validation_options_excluding"} text="Excluding" />
      <TextInput
        id={"entity_fields_#{@parent_name}_validation_options_excluding"}
        name={"entity[fields][#{@parent_name}][validation_options][excluding]"}
        opts={[phx_blur: "blur", phx_value_field: "#{@parent_name}", phx_value_option: "validation_options_excluding"]}
        value={EntityHelper.map_value?(@options, :excluding)}
      />
      <Label field={"fields_#{@parent_name}_validation_options_including"} text="Including" />
      <TextInput
        id={"entity_fields_#{@parent_name}_validation_options_including"}
        name={"entity[fields][#{@parent_name}][validation_options][including]"}
        opts={[phx_blur: "blur", phx_value_field: "#{@parent_name}", phx_value_option: "validation_options_including"]}
        value={EntityHelper.map_value?(@options, :including)}
      />
      <Label field={"fields_#{@parent_name}_validation_options_length"} text="Length" />
      <NumberInput
        id={"entity_fields_#{@parent_name}_validation_options_length"}
        name={"entity[fields][#{@parent_name}][validation_options][length]"}
        opts={[phx_blur: "blur", phx_value_field: "#{@parent_name}", phx_value_option: "validation_options_length"]}
        value={EntityHelper.map_value?(@options, :length)}
      />
    </fieldset>
    """
  end
end
