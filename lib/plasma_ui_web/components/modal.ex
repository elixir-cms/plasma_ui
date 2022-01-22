defmodule PlasmaUiWeb.Components.Modal do
  @moduledoc """
  A simple modal component with animated show/hide.
  """

  use Surface.Component
  alias Phoenix.LiveView.JS

  prop(id, :string)

  prop(callbackId, :string)

  slot(trigger, required: true)

  slot(content, required: true)

  def(render(assigns)) do
    id =
      if assigns.id,
        do: assigns.id,
        else: "modal-" <> (System.unique_integer([:positive, :monotonic]) |> Integer.to_string())

    ~F"""
    <div class="modal" id={id} :hook="Modal">
      <div class="trigger"
           :on-click={
             JS.dispatch("open", to: "##{id}")
             |> JS.dispatch("opened", to: "##{@callbackId}")
           }
        tabindex="0">
        <#slot name="trigger" />
      </div>
      <div class="hidden wrapper">
        <div class="overlay"
             :on-click={
               JS.dispatch("close", to: "##{id}")
               |> JS.dispatch("closed", to: "##{@callbackId}")
             } />
        <div class="content">
          <#slot name="content" />
        </div>
      </div>
    </div>
    """
  end
end
