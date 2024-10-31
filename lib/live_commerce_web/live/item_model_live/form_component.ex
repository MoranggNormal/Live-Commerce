defmodule LiveCommerceWeb.ItemModelLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage item_model records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="item_model-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Item model</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{item_model: item_model} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Products.change_item_model(item_model))
     end)}
  end

  @impl true
  def handle_event("validate", %{"item_model" => item_model_params}, socket) do
    changeset = Products.change_item_model(socket.assigns.item_model, item_model_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"item_model" => item_model_params}, socket) do
    save_item_model(socket, socket.assigns.action, item_model_params)
  end

  defp save_item_model(socket, :edit, item_model_params) do
    case Products.update_item_model(socket.assigns.item_model, item_model_params) do
      {:ok, item_model} ->
        notify_parent({:saved, item_model})

        {:noreply,
         socket
         |> put_flash(:info, "Item model updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_item_model(socket, :new, item_model_params) do
    case Products.create_item_model(item_model_params) do
      {:ok, item_model} ->
        notify_parent({:saved, item_model})

        {:noreply,
         socket
         |> put_flash(:info, "Item model created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
