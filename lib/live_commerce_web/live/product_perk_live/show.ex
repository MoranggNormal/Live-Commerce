defmodule LiveCommerceWeb.ProductPerkLive.Show do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product_perk, Products.get_product_perk!(id))}
  end

  defp page_title(:show), do: "Show Product perk"
  defp page_title(:edit), do: "Edit Product perk"
end
