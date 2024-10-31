defmodule LiveCommerceWeb.CartItemLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Carts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage cart_item records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="cart_item-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cart item</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cart_item: cart_item} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Carts.change_cart_item(cart_item))
     end)}
  end

  @impl true
  def handle_event("validate", %{"cart_item" => cart_item_params}, socket) do
    changeset = Carts.change_cart_item(socket.assigns.cart_item, cart_item_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"cart_item" => cart_item_params}, socket) do
    save_cart_item(socket, socket.assigns.action, cart_item_params)
  end

  defp save_cart_item(socket, :edit, cart_item_params) do
    case Carts.update_cart_item(socket.assigns.cart_item, cart_item_params) do
      {:ok, cart_item} ->
        notify_parent({:saved, cart_item})

        {:noreply,
         socket
         |> put_flash(:info, "Cart item updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_cart_item(socket, :new, cart_item_params) do
    case Carts.create_cart_item(cart_item_params) do
      {:ok, cart_item} ->
        notify_parent({:saved, cart_item})

        {:noreply,
         socket
         |> put_flash(:info, "Cart item created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
