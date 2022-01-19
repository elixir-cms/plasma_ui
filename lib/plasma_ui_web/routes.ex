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
        path: "/entity/:source/alter",
        module: Entity.Alter
      },
      %{
        name: "Content Overview",
        path: "/content",
        module: Content.Overview
      },
      %{
        name: "List Content",
        path: "/content/:source",
        module: Content.List
      },
      %{
        name: "Create Content",
        path: "/content/:source/create",
        module: Content.Create
      },
      %{
        name: "Edit Content",
        path: "/content/:source/:id/edit",
        module: Content.Edit
      }
    ]
  end
end
