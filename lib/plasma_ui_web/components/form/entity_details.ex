defmodule PlasmaUiWeb.Components.Form.EntityDetails do
  @moduledoc """
  A group of inputs used for managing the general details of an entity.
  """

  use Surface.Component
  alias Surface.Components.Form.{Label, TextInput}

  prop(editing, :boolean, required: true)
  prop(entity, :map, required: true)

  def render(assigns) do
    source_style = if assigns.editing, do: "display:none", else: ""

    ~F"""
    <fieldset class="border" form="entity" name="entity_details">
      <legend>Entity details</legend>
      <Label field="label" />
      <TextInput id="entity_label" name="entity[label]" opts={required: true} value={@entity.label} />
      <Label field="source" opts={[style: source_style]} />
      <TextInput
        id="entity_source"
        name="entity[source]"
        opts={[style: source_style, required: true]}
        value={@entity.source}
      />
      <Label field="singular" />
      <TextInput
        id="entity_singular"
        name="entity[singular]"
        opts={required: true}
        value={@entity.singular}
      />
      <Label field="plural" />
      <TextInput
        id="entity_plural"
        name="entity[plural]"
        opts={required: true}
        value={@entity.plural}
      />
    </fieldset>
    """
  end
end
