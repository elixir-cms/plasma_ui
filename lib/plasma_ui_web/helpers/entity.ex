defmodule PlasmaUiWeb.Helpers.Entity do
  @moduledoc """
  A module that returns example data for an entity.
  """

  def convert_string_to_atom_keys(value) do
    if is_map(value) do
      value
      |> Map.keys()
      |> Enum.reduce(%{}, fn key, acc ->
        unless key == "filters" || key == "meta" || value[key] == "" do
          Map.put(acc, String.to_atom(key), convert_string_to_atom_keys(value[key]))
        else
          cond do
            key == "filters" ->
              if value[key] == "" do
                Map.put(acc, String.to_atom(key), [])
              else
                Map.put(acc, String.to_atom(key), value[key])
              end

            key == "meta" ->
              Map.put(acc, String.to_atom(key), value[key])

            true ->
              acc
          end
        end
      end)
    else
      cond do
        value == "true" ->
          true

        value == "false" ->
          false

        true ->
          value
      end
    end
  end

  def adapt_fields(fields) do
    fields
    |> Map.keys()
    |> Enum.reduce(%{}, fn key, acc ->
      if Map.has_key?(fields[key], "meta") do
        Map.put(acc, key, convert_string_to_atom_keys(fields[key]))
      else
        Map.put(acc, key, convert_string_to_atom_keys(Map.put(fields[key], "meta", %{})))
      end
    end)
  end

  def map_value?(map, name) do
    if Map.has_key?(map, name) do
      {:ok, value} = Map.fetch(map, name)
      if value, do: value, else: false
    end
  end

  def get_empty_details() do
    %{
      :source => "",
      :label => "",
      :singular => "",
      :plural => ""
    }
  end

  def get_new_field() do
    %{
      :field_name => "",
      :field_type => "string",
      :storage_type => "string",
      :persistence_options => %{
        :primary_key => true,
        :nullable => false,
        :indexed => false,
        :unique => true,
        :default => "default"
      },
      :validation_options => %{
        :required => true,
        :format => false,
        :number => false,
        :excluding => false,
        :including => false,
        :length => 5
      },
      :filters => [],
      :meta => %{}
    }
  end
end
