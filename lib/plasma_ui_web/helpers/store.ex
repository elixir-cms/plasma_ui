defmodule PlasmaUiWeb.Helpers.Store do
  @moduledoc """
  A helper module for working with the EctoEntity Store
  """

  alias EctoEntity.Store

  def get_settings do
    Store.init(%{
      type_storage: %{
        module: EctoEntity.Store.SimpleJson,
        settings: %{directory_path: Path.join(File.cwd!(), "store")}
      },
      repo: %{module: Repo, dynamic: false}
    })
  end

  def get_type(source) do
    get_settings() |> Store.get_type(source)
  end

  def list_types do
    get_settings() |> Store.list_types()
  end

  def put_type(type) do
    get_settings() |> Store.put_type(type)
  end

  def remove_type(source) do
    get_settings() |> Store.remove_type(source)
  end
end
