defmodule LiveCommerceWeb.ClassificationLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage classification records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="classification-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Classification</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{classification: classification} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Products.change_classification(classification))
     end)}
  end

  @impl true
  def handle_event("validate", %{"classification" => classification_params}, socket) do
    changeset = Products.change_classification(socket.assigns.classification, classification_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"classification" => classification_params}, socket) do
    save_classification(socket, socket.assigns.action, classification_params)
  end

  defp save_classification(socket, :edit, classification_params) do
    case Products.update_classification(socket.assigns.classification, classification_params) do
      {:ok, classification} ->
        notify_parent({:saved, classification})

        {:noreply,
         socket
         |> put_flash(:info, "Classification updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_classification(socket, :new, classification_params) do
    case Products.create_classification(classification_params) do
      {:ok, classification} ->
        notify_parent({:saved, classification})

        {:noreply,
         socket
         |> put_flash(:info, "Classification created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
