defmodule LiveCommerceWeb.WishlistLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Accounts
  alias LiveCommerce.Accounts.Wishlist

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :wishlists, Accounts.list_wishlists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Wishlist")
    |> assign(:wishlist, Accounts.get_wishlist!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Wishlist")
    |> assign(:wishlist, %Wishlist{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Wishlists")
    |> assign(:wishlist, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.WishlistLive.FormComponent, {:saved, wishlist}}, socket) do
    {:noreply, stream_insert(socket, :wishlists, wishlist)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    wishlist = Accounts.get_wishlist!(id)
    {:ok, _} = Accounts.delete_wishlist(wishlist)

    {:noreply, stream_delete(socket, :wishlists, wishlist)}
  end
end
