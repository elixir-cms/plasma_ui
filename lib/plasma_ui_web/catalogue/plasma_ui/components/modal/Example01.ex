defmodule PlasmaUiWeb.Components.Modal.Example01 do
  use Surface.Catalogue.Example,
    catalogue: PlasmaUiWeb.Components.Catalogue,
    subject: PlasmaUiWeb.Components.Modal,
    height: "400px"

  def render(assigns) do
    ~F"""
    <Modal>
      <:trigger>
        <div class="button">Open Modal</div>
      </:trigger>
      <:content>
        <p>Pellentesque condimentum, magna ut suscipit hendrerit, ipsum augue ornare nulla, non luctus diam neque sit amet urna.</p>
        <div class="button close" @click="showModal = false">Close Modal</div>
      </:content>
    </Modal>
    """
  end
end
