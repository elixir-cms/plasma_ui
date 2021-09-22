defmodule PlasmaUiWeb.Entity.Create do
  @moduledoc """
  A liveview page that allows users to create a new entity.
  """

  use Surface.LiveView
  alias Surface.Components.Form
  alias PlasmaUiWeb.Components.Form.{EntityDetails}
  alias PlasmaUiWeb.Helpers.Entity
  alias EctoEntity.Store
  alias EctoEntity.Type

  def mount(_params, _session, socket) do
    entity = Map.merge(Entity.get_empty_details(), %{fields: %{}})

    initial_socket =
      socket
      |> assign(:entity, entity)
      |> assign(:new_field, Entity.get_new_field())

    {:ok, initial_socket}
  end

  def render(assigns) do
    ~F"""
    <section>
      <h2>Create Entity</h2>
      <article>
        <p>Use this form to create a new entity.</p>
        <Form for={:entity} submit="submit" opts={id: "entity"}>
          <EntityDetails entity={@entity} editing={false} />
          <button type="submit">Create Entity</button>
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

  def handle_event(
        "submit",
        %{
          "entity" => %{
            "source" => source,
            "label" => label,
            "singular" => singular,
            "plural" => plural
          }
        },
        socket
      ) do
    type =
      Type.new(source, label, singular, plural)
      |> Type.migration_defaults!(fn set -> set end)

    store =
      Store.init(%{
        type_storage: %{
          module: EctoEntity.Store.SimpleJson,
          settings: %{directory_path: Path.join(System.tmp_dir(), "store")}
        },
        repo: %{module: Repo, dynamic: false}
      })

    Store.put_type(store, type)
    IO.inspect(Store.get_type(store, source))

    # {:noreply, push_redirect(socket, to: "/")}
    {:noreply, socket}
  end
end
