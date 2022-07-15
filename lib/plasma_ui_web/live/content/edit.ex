defmodule PlasmaUiWeb.Content.Edit do
  @moduledoc """
  A liveview page provides a content editing interface for individual entries of any entity type.
  """

  use Surface.LiveView
  alias PlasmaUiWeb.Components.Alerts
  alias PlasmaUiWeb.Components.DynamicField
  alias PlasmaUiWeb.Components.Nav
  alias PlasmaUiWeb.Helpers.Content
  alias PlasmaUiWeb.Helpers.Store
  alias Surface.Components.Form

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <Alerts flash={@flash} />
      <article>
        <h3>Edit {@entity.singular |> Phoenix.Naming.humanize()}</h3>
        <Form for={:entry} submit="submit" opts={id: "entry"}>
          <fieldset class="border" form="entry" name="fields">
            <legend>Fields</legend>
            <div class="mb-4" :for={{field_name, field} <- Map.to_list(@entity.fields)} }>
              <label>{field_name |> Phoenix.Naming.humanize()}</label>
              <DynamicField
                fieldName={field_name}
                fieldType={field.field_type}
                value={@entry[field_name]}
              />
            </div>
          </fieldset>
          <button id="update" type="submit">Update</button>
        </Form>
      </article>
    </section>
    """
  end

  def mount(params, _session, socket) do
    {:ok, entity} = Store.get_type(params["source"])

    entry = Content.generate_entry(entity)

    initial_socket =
      socket
      |> assign(:entity, entity)
      |> assign(:entry, entry)

    {:ok, initial_socket}
  end

  def handle_event(
        "toggle_switch_changed",
        %{"field_name" => field_name, "field_type" => "boolean", "value" => value},
        socket
      ) do
    new_entry = socket.assigns.entry |> Map.replace!(field_name, value)
    {:noreply, socket |> assign(:entry, new_entry)}
  end

  def handle_event(
        "date_picker_changed",
        %{"field_name" => field_name, "field_type" => "naive_datetime", "value" => value},
        socket
      ) do
    new_entry = socket.assigns.entry |> Map.replace!(field_name, value)
    {:noreply, socket |> assign(:entry, new_entry)}
  end

  def handle_event("submit", _, socket) do
    new_socket =
      socket
      |> put_flash(:info, "Entity updated!")

    Process.send_after(self(), :clear_flash, 3000, [])

    {:noreply, new_socket}
  end

  def handle_event(field_name, %{"value" => value}, socket) do
    new_value =
      case value do
        "on" -> true
        _ -> value
      end

    new_entry = socket.assigns.entry |> Map.replace!(field_name, new_value)
    {:noreply, socket |> assign(:entry, new_entry)}
  end

  def handle_event(field_name, %{}, socket) do
    new_entry = socket.assigns.entry |> Map.replace!(field_name, false)
    {:noreply, socket |> assign(:entry, new_entry)}
  end

  def handle_info(:clear_flash, socket) do
    {:noreply, socket |> clear_flash}
  end
end
