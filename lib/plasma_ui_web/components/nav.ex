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
        <nav role="navigation" class="w-full">
          <ul class="text-center">
            <li class="inline-block mx-4">
              <LivePatch to="/content">Content</LivePatch>
            </li>
            <li class="inline-block mx-4">
              <LivePatch to="/">Entities</LivePatch>
            </li>
          </ul>
        </nav>
      </section>
    </header>
    """
  end
end
