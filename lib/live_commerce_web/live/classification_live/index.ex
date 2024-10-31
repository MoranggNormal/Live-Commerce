defmodule LiveCommerceWeb.ClassificationLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Products
  alias LiveCommerce.Products.Classification

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :classifications, Products.list_classifications())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Classification")
    |> assign(:classification, Products.get_classification!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Classification")
    |> assign(:classification, %Classification{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Classifications")
    |> assign(:classification, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.ClassificationLive.FormComponent, {:saved, classification}}, socket) do
    {:noreply, stream_insert(socket, :classifications, classification)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    classification = Products.get_classification!(id)
    {:ok, _} = Products.delete_classification(classification)

    {:noreply, stream_delete(socket, :classifications, classification)}
  end
end
