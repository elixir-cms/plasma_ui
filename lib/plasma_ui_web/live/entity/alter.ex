defmodule PlasmaUiWeb.Entity.Alter do
  @moduledoc """
  A liveview page that shows the alter entity form.
  """

  use Surface.LiveView
  alias Surface.Components.Form
  alias PlasmaUiWeb.Components.Accordion
  alias PlasmaUiWeb.Components.Form.{EntityDetails, EntityField}
  alias PlasmaUiWeb.Helpers.Entity

  def mount(_params, _session, socket) do
    entity = Map.merge(Entity.get_details(), %{fields: Entity.get_fields()})
    {:ok, assign(socket, :entity, entity)}
  end

  def render(assigns) do
    ~H"""
    <section>
      <h2>Alter Entity - {{ @entity.label }}</h2>
      <article>
        <p>Use this form to alter entity details and fields associated with the entity.</p>
        <Form for={{ :entity }} change="change" opts={{ id: "entity" }}>
          <EntityDetails entity={{ @entity }} />
          <fieldset class="border" form="entity" name="entity[fields]">
            <legend>Fields</legend>
            <Accordion
              :for={{ {field_name, field} <- Map.to_list(@entity.fields) }}
              title={{ Phoenix.HTML.Form.humanize(field_name) }}
            >
              <EntityField field={{ field }} name={{ field_name }} />
            </Accordion>
          </fieldset>
        </Form>
      </article>
    </section>
    """
  end

  def handle_event("change", %{"entity" => params}, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end
end
