defmodule LiveCommerceWeb.ProductCoverImageLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products
  alias LiveCommerce.Products.ProductCoverImage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :product_cover_images, Products.list_product_cover_images())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product cover image")
    |> assign(:product_cover_image, Products.get_product_cover_image!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product cover image")
    |> assign(:product_cover_image, %ProductCoverImage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Product cover images")
    |> assign(:product_cover_image, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.ProductCoverImageLive.FormComponent, {:saved, product_cover_image}}, socket) do
    {:noreply, stream_insert(socket, :product_cover_images, product_cover_image)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product_cover_image = Products.get_product_cover_image!(id)
    {:ok, _} = Products.delete_product_cover_image(product_cover_image)

    {:noreply, stream_delete(socket, :product_cover_images, product_cover_image)}
  end
end
