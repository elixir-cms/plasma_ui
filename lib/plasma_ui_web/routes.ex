defmodule PlasmaUiWeb.Routes do
  @moduledoc """
  A module that returns a list of routes.
  """
  def list() do
    [
      %{
        name: "Create Entity",
        path: "/entity/create",
        module: Entity.Create
      },
      %{
        name: "Alter Entity",
        path: "/entity/alter",
        module: Entity.Alter
      }
    ]
  end
end
