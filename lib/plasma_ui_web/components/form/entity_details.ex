defmodule PlasmaUiWeb.Components.Form.EntityDetails do
  @moduledoc """
  A group of inputs used for managing the general details of an entity.
  """

  use Surface.Component
  alias Surface.Components.Form.{Label, TextInput}

  prop entity, :map, required: true

  def render(assigns) do
    ~H"""
    <fieldset class="border" form="entity" name="entity_details">
      <legend>Entity details</legend>
      <Label field="label" />
      <TextInput id="entity_label" name="entity[label]" value={{ @entity.label }} />
      <Label field="source" />
      <TextInput
        id="entity_source"
        name="entity[source]"
        opts={{ [disabled: true] }}
        value={{ @entity.source }}
      />
      <Label field="singular" />
      <TextInput id="entity_singular" name="entity[singular]" value={{ @entity.singular }} />
      <Label field="plural" />
      <TextInput id="entity_plural" name="entity[plural]" value={{ @entity.plural }} />
    </fieldset>
    """
  end
end
