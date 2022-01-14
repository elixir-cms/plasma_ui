defmodule PlasmaUiWeb.Components.Nav do
  @moduledoc """
  A simple navigation list for the header.
  """

  use Surface.Component
  alias Surface.Components.LivePatch

  def render(assigns) do
    ~F"""
    <header>
      <section class="container">
        <nav role="navigation">
          <ul>
            <li>
              <LivePatch to="/">Entities</LivePatch>
            </li>
            <li>
              <LivePatch to="/entity/create">Create Entity</LivePatch>
            </li>
          </ul>
        </nav>
      </section>
    </header>
    """
  end
end
