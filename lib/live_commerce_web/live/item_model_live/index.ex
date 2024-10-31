defmodule LiveCommerceWeb.ItemModelLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products
  alias LiveCommerce.Products.ItemModel

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :item_models, Products.list_item_models())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Item model")
    |> assign(:item_model, Products.get_item_model!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item model")
    |> assign(:item_model, %ItemModel{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Item models")
    |> assign(:item_model, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.ItemModelLive.FormComponent, {:saved, item_model}}, socket) do
    {:noreply, stream_insert(socket, :item_models, item_model)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item_model = Products.get_item_model!(id)
    {:ok, _} = Products.delete_item_model(item_model)

    {:noreply, stream_delete(socket, :item_models, item_model)}
  end
end
