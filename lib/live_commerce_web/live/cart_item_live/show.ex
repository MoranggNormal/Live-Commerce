defmodule LiveCommerceWeb.CartItemLive.Show do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Carts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cart_item, Carts.get_cart_item!(id))}
  end

  defp page_title(:show), do: "Show Cart item"
  defp page_title(:edit), do: "Edit Cart item"
end
