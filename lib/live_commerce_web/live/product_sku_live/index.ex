defmodule LiveCommerceWeb.ProductSKULive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products
  alias LiveCommerce.Products.ProductSKU

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :products_skus, Products.list_products_skus())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product sku")
    |> assign(:product_sku, Products.get_product_sku!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product sku")
    |> assign(:product_sku, %ProductSKU{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products skus")
    |> assign(:product_sku, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.ProductSKULive.FormComponent, {:saved, product_sku}}, socket) do
    {:noreply, stream_insert(socket, :products_skus, product_sku)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product_sku = Products.get_product_sku!(id)
    {:ok, _} = Products.delete_product_sku(product_sku)

    {:noreply, stream_delete(socket, :products_skus, product_sku)}
  end
end
