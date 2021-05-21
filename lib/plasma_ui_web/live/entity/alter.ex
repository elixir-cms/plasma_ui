defmodule PlasmaUiWeb.Entity.Alter do
  use Surface.LiveView
  alias Surface.Components.Form
  alias PlasmaUiWeb.Components.Form.EntityField
  alias Surface.Components.Form.{Field, TextInput}

  @details %{
    "source" => "",
    "label" => "",
    "singular" => "",
    "plural" => ""
  }

  @fields %{
    example_text: %{
      field_type: "text",
      storage_type: "binary",
      persistence_options: %{
        nullable: false,
        indexed: false,
        unique: true,
        default: "default"
      },
      validation_options: %{
        required: true,
        format: false,
        number: false,
        excluding: false,
        including: false,
        length: %{}
      },
      filters: [],
      meta: %{},
      value: ''
    },
    example_textarea: %{
      field_type: "textarea",
      storage_type: "binary",
      persistence_options: %{
        nullable: false,
        indexed: false,
        unique: true,
        default: "default"
      },
      validation_options: %{
        required: true,
        format: false,
        number: false,
        excluding: false,
        including: false,
        length: %{}
      },
      filters: [],
      meta: %{},
      value: ''
    }
  }

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :entity, Map.merge(@details, %{fields: @fields}))}
  end

  def render(assigns) do
    ~H"""
    <Form for={{ :entity }} change="change" opts={{ id: "entity" }}>
      <Context put={{ entity: @entity }}>
        <fieldset name="details">
          <Field name="label">
            <TextInput />
          </Field>
          <Field name="source">
            <TextInput />
          </Field>
          <Field name="singular">
            <TextInput />
          </Field>
          <Field name="plural">
            <TextInput />
          </Field>
        </fieldset>
        <fieldset form="entity" name="fields">
          <EntityField :for={{ field_name <- Map.keys(@entity.fields) }} name={{ field_name }} />
        </fieldset>
      </Context>
    </Form>
    """
  end

  def handle_event("change", %{"entity" => params}, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end
end
