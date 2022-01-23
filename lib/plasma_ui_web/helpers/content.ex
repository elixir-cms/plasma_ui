defmodule PlasmaUiWeb.Helpers.Content do
  @moduledoc """
  A module with helper functions for working with content.
  """

  def generate_entry(entity) do
    entity.fields
    |> Map.keys()
    |> Enum.reduce(%{}, fn key, acc ->
      value =
        case entity.fields[key].field_type do
          "boolean" ->
            true

          "string" ->
            "Hello"

          "naive_datetime" ->
            {:ok, now} = NaiveDateTime.new(~D[2022-01-20], ~T[23:00:07.005])
            now

          _ ->
            raise "Unrecognized field_type: #{entity.fields[key].field_type}"
        end

      Map.put(acc, key, value)
    end)
  end
end
