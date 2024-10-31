defmodule LiveCommerceWeb.ProductPerkLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products
  alias LiveCommerce.Products.ProductPerk

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :product_perks, Products.list_product_perks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product perk")
    |> assign(:product_perk, Products.get_product_perk!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product perk")
    |> assign(:product_perk, %ProductPerk{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Product perks")
    |> assign(:product_perk, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.ProductPerkLive.FormComponent, {:saved, product_perk}}, socket) do
    {:noreply, stream_insert(socket, :product_perks, product_perk)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product_perk = Products.get_product_perk!(id)
    {:ok, _} = Products.delete_product_perk(product_perk)

    {:noreply, stream_delete(socket, :product_perks, product_perk)}
  end
end
