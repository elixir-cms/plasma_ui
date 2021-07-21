defmodule PlasmaUiWeb.Entity.Alter do
  @moduledoc """
  A liveview page that shows the alter entity form.
  """

  use Surface.LiveView
  alias Surface.Components.Form
  alias PlasmaUiWeb.Components.{Accordion, Modal}
  alias PlasmaUiWeb.Components.Form.{EntityDetails, EntityField, NewField}
  alias PlasmaUiWeb.Helpers.Entity

  def mount(_params, _session, socket) do
    entity = Map.merge(Entity.get_details(), %{fields: Entity.get_fields()})

    initial_socket =
      socket
      |> assign(:entity, entity)
      |> assign(:new_field, Entity.get_new_field())

    {:ok, initial_socket}
  end

  def render(assigns) do
    ~F"""
    <section>
      <h2>Alter Entity - {@entity.label}</h2>
      <article>
        <p>Use this form to alter entity details and fields associated with the entity.</p>
        <Form for={:entity} change="change" opts={id: "entity"}>
          <EntityDetails entity={@entity} editing={true} />
          <fieldset class="border pb-2" form="entity" name="entity[fields]">
            <legend>Fields</legend>
            <Accordion
              :for={{field_name, field} <- Map.to_list(@entity.fields)}
              title={Phoenix.HTML.Form.humanize(field_name)}>
              <EntityField field={field} name={field_name} />
            </Accordion>
            <Modal>
              <#template slot="trigger">
                <div class="button mt-4">Add field</div>
              </#template>
              <#template slot="content">
                <Form for={:new_field} submit="add_field" opts={id: "new_field"}>
                  <NewField  field={@new_field} />
                  <button @click="showModal = false" type="submit">Add field</button>
                  <div class="button gray" @click="showModal = false">Cancel</div>
                </Form>
              </#template>
            </Modal>
          </fieldset>
          <button type="submit">Update Entity</button>
        </Form>
      </article>
    </section>
    """
  end

  def handle_event("add_field", %{"new_field" => field}, socket) do
    entity = socket.assigns.entity

    new_field =
      field
      |> Map.merge(socket.assigns.new_field)
      |> Map.delete("field_name")

    new_entity =
      Map.put(entity, :fields, Map.put_new(entity.fields, field["field_name"], new_field))

    new_socket = socket |> assign(:entity, new_entity)
    {:noreply, new_socket}
  end

  def handle_event("change", %{"entity" => _params}, socket) do
    {:noreply, socket}
  end
end
