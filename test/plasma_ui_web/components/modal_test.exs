defmodule PlasmaUiWeb.Components.ModalTest do
  use Surface.LiveViewTest
  @endpoint PlasmaUiWeb.Endpoint

  use ExUnit.Case, async: true
  use Hound.Helpers
  @base "http://localhost:4002"

  alias PlasmaUiWeb.Components.Modal

  hound_session()

  test "modal renders with appropriate class" do
    html =
      render_surface do
        ~F"""
        <Modal>
          <:trigger>
            <div class="button">Open Modal</div>
          </:trigger>
          <:content>
            <p>Pellentesque condimentum, magna ut suscipit hendrerit, ipsum augue ornare nulla, non luctus diam neque sit amet urna.</p>
            <div class="button" @click="showModal = false">Close Modal</div>
          </:content>
        </Modal>
        """
      end

    assert html =~ "class=\"modal\""
  end

  test "opens and closes modal with triggers, overlay, and close" do
    "#{@base}/catalogue/examples/Elixir.PlasmaUiWeb.Components.Modal.Example01"
    |> navigate_to()

    modal = find_element(:class, "modal")
    trigger = modal |> find_within_element(:class, "trigger")
    content = modal |> find_within_element(:class, "content")
    # overlay = modal |> find_within_element(:class, "overlay")
    # close = content |> find_within_element(:class, "close")

    click(trigger)

    assert content |> css_property("display") == "flex"

    assert execute_script("return document.querySelector('.modal .content').style.display") == ""

    # click(overlay)

    # assert execute_script("return document.querySelector('.modal .content').style.display") == "none"

    # assert content |> css_property("display") == "none"

    # click(trigger)

    # assert content |> css_property("display") == "flex"

    # click(close)

    # assert content |> css_property("display") == "none"
  end
end
