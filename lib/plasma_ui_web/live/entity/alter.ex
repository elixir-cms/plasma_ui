defmodule PlasmaUiWeb.Entity.Alter do
  @moduledoc """
  A liveview page that shows the alter entity form.
  """

  use Surface.LiveView
  alias EctoEntity.Type
  alias Surface.Components.Form
  alias PlasmaUiWeb.Components.Accordion
  alias PlasmaUiWeb.Components.Alerts
  alias PlasmaUiWeb.Components.Modal
  alias PlasmaUiWeb.Components.Nav
  alias PlasmaUiWeb.Components.Form.{EntityDetails, EntityField, NewField}
  alias PlasmaUiWeb.Helpers.Entity, as: EntityHelper
  alias PlasmaUiWeb.Helpers.Store
  alias Phoenix.LiveView.JS

  def render(assigns) do
    ~F"""
    <Nav />
    <section>
      <Alerts flash={@flash} />
      <article id="alter" :hook="Alter">
        <h3>Alter {@entity.label}</h3>
        <Form for={:entity} submit="submit" opts={id: "entity"}>
          <EntityDetails entity={@entity} editing />
          <fieldset class="border" form="entity" name="entity[:fields]">
            <legend>Fields</legend>
            <Accordion
              :for={{field_name, field} <- Map.to_list(@entity.fields)}
              title={Phoenix.HTML.Form.humanize(field_name)}
            >
              <EntityField field={field} name={field_name} />
            </Accordion>
          </fieldset>
          <button id="update-entity" type="submit">Update Entity</button>
        </Form>
         <Modal id="add-field-modal" callbackId="alter">
          <:trigger>
            <div class="flex float-right justify-end w-8" style="transform: translateY(-100%)">
              <div class="button mt-4" id="add-field">
                Add field
              </div>
            </div>
          </:trigger>
          <:content>
            <Form for={:new_field} submit="add_field" opts={id: "new_field"}>
              <NewField field={@new_field} />
              <button type="submit">Add field</button>
              <button class="gray"
                      type="button"
                      :on-click={JS.dispatch("close", to: "#add-field-modal")}>
                Cancel
              </button>
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
      |> assign(:changes, [])
      |> assign(:new_field, EntityHelper.get_new_field())

    {:ok, initial_socket}
  end

  defp clean_val(value) do
    case value do
      true ->
        true

      false ->
        false

      "true" ->
        true

      nil ->
        false

      _ ->
        value
    end
  end

  defp merge_key(acc, key, value) do
    keyword = Keyword.new() |> Keyword.put_new(key, clean_val(value))
    Keyword.merge(acc, keyword)
  end

  def handle_info(:clear_flash, socket) do
    {:noreply, socket |> clear_flash}
  end

  def handle_event(
        "add_field",
        %{
          "new_field" => %{
            "field_name" => field_name,
            "field_type" => field_type,
            "storage_type" => storage_type
          }
        },
        socket
      ) do
    new_entity =
      socket.assigns.entity
      |> Type.add_field!(field_name, field_type, storage_type,
        nullable: false,
        indexed: false,
        unique: true,
        required: true
      )

    new_socket =
      socket
      |> assign(:entity, new_entity)
      |> put_flash(:info, "Field added!")

    JS.dispatch("close", to: "#add-field-modal")

    {:noreply, new_socket}
  end

  def handle_event("submit", _, socket) do
    type = socket.assigns.entity

    {:ok, entity} =
      socket.assigns.changes
      |> Enum.reduce(%{}, fn change, acc ->
        fieldname = change[:fieldname]
        existing_changes = acc[fieldname]
        new_change = Map.delete(change, :fieldname)

        if is_list(existing_changes) do
          field_changes = Map.put(%{}, fieldname, Enum.concat(existing_changes, [new_change]))
          Map.merge(acc, field_changes)
        else
          Map.put(acc, fieldname, [new_change])
        end
      end)
      |> Enum.map(fn {fieldname, field_changes} ->
        changeset =
          field_changes
          |> Enum.reduce(Keyword.new(), fn %{key: _, subkey: subkey, value: value}, acc ->
            case subkey do
              :primary_key ->
                IO.puts("unhandled :primary_key change to #{value}")
                acc

              :indexed ->
                if clean_val(value),
                  do: merge_key(acc, :add_index, true),
                  else: merge_key(acc, :drop_index, true)

              :nullable ->
                merge_key(acc, :make_nullable, value)

              :unique ->
                merge_key(acc, :remove_uniqueness, value)

              :default ->
                merge_key(acc, :set_default, value)

              _ ->
                merge_key(acc, subkey, value)
            end
          end)

        {fieldname, changeset}
      end)
      |> Enum.reduce(type, fn {fieldname, changeset}, acc ->
        Type.alter_field!(acc, fieldname, changeset)
      end)
      |> Store.put_type()

    new_socket =
      socket
      |> assign(:entity, entity)
      |> put_flash(:info, "Entity updated!")

    Process.send_after(self(), :clear_flash, 3000, [])

    {:noreply, new_socket}
  end

  def handle_event("blur", val, socket) do
    fieldname = val["fieldname"]
    field = socket.assigns.entity.fields["#{fieldname}"]

    if is_map(field) do
      key = String.to_existing_atom(val["key"])
      field_key = field |> Map.fetch(key) |> elem(1)
      subkey = String.to_existing_atom(val["subkey"])
      value = val["value"]

      cond do
        is_nil(subkey) ->
          if field_key != value do
            new_socket =
              socket
              |> assign(
                :changes,
                Enum.concat([
                  socket.assigns.changes,
                  [%{fieldname: fieldname, key: key, value: value}]
                ])
              )

            {:noreply, new_socket}
          else
            {:noreply, socket}
          end

        not is_nil(val["subkey"]) and Map.has_key?(field_key, subkey) ->
          field_subkey = field_key |> Map.fetch(subkey) |> elem(1)

          if not (field_subkey == value or (field_subkey and value == "true") or
                    (!field_subkey and value == nil)) do
            new_socket =
              socket
              |> assign(
                :changes,
                Enum.concat(
                  socket.assigns.changes,
                  [
                    %{
                      fieldname: fieldname,
                      key: key,
                      subkey: subkey,
                      value: value
                    }
                  ]
                )
              )

            {:noreply, new_socket}
          else
            {:noreply, socket}
          end

        is_map(field_key) and not Map.has_key?(field_key, subkey) ->
          if field_key == value or (!!value and value != "") do
            new_socket =
              socket
              |> assign(
                :changes,
                Enum.concat(
                  socket.assigns.changes,
                  [
                    %{
                      fieldname: fieldname,
                      key: key,
                      subkey: subkey,
                      value: value
                    }
                  ]
                )
              )

            {:noreply, new_socket}
          else
            {:noreply, socket}
          end

        true ->
          IO.inspect('no match')
          {:noreply, socket}
      end
    else
      {:noreply, socket}
    end
  end

  def handle_event("label", val, socket) do
    if socket.assigns.entity.label != val["value"] do
      IO.inspect("label changed #{val}")
    end

    {:noreply, socket}
  end

  def handle_event("singular", val, socket) do
    if socket.assigns.entity.singular != val["value"] do
      IO.inspect("singular changed to #{val}")
    end

    {:noreply, socket}
  end

  def handle_event("plural", val, socket) do
    if socket.assigns.entity.plural != val["value"] do
      IO.inspect("plural changed to #{val}")
    end

    {:noreply, socket}
  end
end
