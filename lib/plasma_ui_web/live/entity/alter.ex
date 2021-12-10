defmodule PlasmaUiWeb.Entity.Alter do
  @moduledoc """
  A liveview page that shows the alter entity form.
  """

  use Surface.LiveView
  alias Surface.Components.Form
  alias PlasmaUiWeb.Components.{Accordion, Modal}
  alias PlasmaUiWeb.Components.Form.{EntityDetails, EntityField, NewField}
  alias PlasmaUiWeb.Helpers.Entity, as: EntityHelper
  alias PlasmaUiWeb.Helpers.Store

  def render(assigns) do
    ~F"""
    <section>
      <h2>Alter Entity - {@entity.label}</h2>
      <article>
        <p>Use this form to alter entity details and fields associated with the entity.</p>
        <Form for={:entity} submit="submit" opts={id: "entity"}>
          <EntityDetails entity={@entity} editing />
          <fieldset class="border pb-6" form="entity" name="entity[:fields]">
            <legend>Fields</legend>
            <Accordion
              :for={{field_name, field} <- Map.to_list(@entity.fields)}
              title={Phoenix.HTML.Form.humanize(field_name)}
            >
              <EntityField field={field} name={field_name} />
            </Accordion>
          </fieldset>
          <button type="submit">Update Entity</button>
        </Form>
        <Modal>
          <:trigger>
            <div class="flex float-right justify-end w-8" style="transform: translateY(-100%)">
              <div class="button mt-4">Add field</div>
            </div>
          </:trigger>
          <:content>
            <Form for={:new_field} submit="add_field" opts={id: "new_field"}>
              <NewField field={@new_field} />
              <button @click="showModal = false" type="submit">Add field</button>
              <div class="button gray" @click="showModal = false">Cancel</div>
            </Form>
          </:content>
        </Modal>
      </article>
    </section>
    """
  end

  def mount(params, _session, socket) do
    {:ok, entity} = Store.get_type(params["source"])

    initial_socket =
      socket
      |> assign(:original_entity, entity)
      |> assign(:entity, entity)
      |> assign(:new_field, EntityHelper.get_new_field())

    {:ok, initial_socket}
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

  def handle_event(
        "submit",
        %{
          "entity" => %{
            "fields" => fields,
            "label" => label,
            "plural" => plural,
            "singular" => singular,
            "source" => source
          }
        },
        socket
      ) do
    new_entity = %{
      :fields => EntityHelper.adapt_fields(fields),
      :label => label,
      :plural => plural,
      :singular => singular,
      :source => source
    }


    {:noreply, socket}
  end

  def handle_event(_, val, socket) do
    IO.inspect(val)
    {:noreply, socket}
  end
end
