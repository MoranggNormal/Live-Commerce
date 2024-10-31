defmodule LiveCommerceWeb.ProductAttributeLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products
  alias LiveCommerce.Products.ProductAttribute

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :product_attributes, Products.list_product_attributes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product attribute")
    |> assign(:product_attribute, Products.get_product_attribute!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product attribute")
    |> assign(:product_attribute, %ProductAttribute{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Product attributes")
    |> assign(:product_attribute, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.ProductAttributeLive.FormComponent, {:saved, product_attribute}}, socket) do
    {:noreply, stream_insert(socket, :product_attributes, product_attribute)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product_attribute = Products.get_product_attribute!(id)
    {:ok, _} = Products.delete_product_attribute(product_attribute)

    {:noreply, stream_delete(socket, :product_attributes, product_attribute)}
  end
end
