defmodule LiveCommerceWeb.SubCategoryLive.Show do
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
     |> assign(:sub_category, Products.get_sub_category!(id))}
  end

  defp page_title(:show), do: "Show Sub category"
  defp page_title(:edit), do: "Edit Sub category"
end
