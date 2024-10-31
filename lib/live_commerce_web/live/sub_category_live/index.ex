defmodule LiveCommerceWeb.SubCategoryLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products
  alias LiveCommerce.Products.SubCategory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :sub_categories, Products.list_sub_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sub category")
    |> assign(:sub_category, Products.get_sub_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sub category")
    |> assign(:sub_category, %SubCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sub categories")
    |> assign(:sub_category, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.SubCategoryLive.FormComponent, {:saved, sub_category}}, socket) do
    {:noreply, stream_insert(socket, :sub_categories, sub_category)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sub_category = Products.get_sub_category!(id)
    {:ok, _} = Products.delete_sub_category(sub_category)

    {:noreply, stream_delete(socket, :sub_categories, sub_category)}
  end
end
