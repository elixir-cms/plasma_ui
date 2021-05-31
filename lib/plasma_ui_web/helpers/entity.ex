defmodule PlasmaUiWeb.Helpers.Entity do
  @moduledoc """
  A module that returns example data for an entity.
  """

  def get_details() do
    %{
      source: "post",
      label: "Post",
      singular: "post",
      plural: "posts"
    }
  end

  def get_fields() do
    %{
      example_text: %{
        field_type: "text",
        storage_type: "binary",
        persistence_options: %{
          primary_key: true,
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
          length: 5
        },
        filters: [],
        meta: %{}
      },
      example_textarea: %{
        field_type: "textarea",
        storage_type: "binary",
        persistence_options: %{
          primary_key: true,
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
          length: 5
        },
        filters: [
          %{
            type: "whatever",
            args: ["foo", "bar"]
          }
        ],
        meta: %{}
      }
    }
  end
end
