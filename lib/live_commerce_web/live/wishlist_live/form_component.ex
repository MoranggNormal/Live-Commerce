defmodule LiveCommerceWeb.WishlistLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage wishlist records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="wishlist-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Wishlist</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{wishlist: wishlist} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Accounts.change_wishlist(wishlist))
     end)}
  end

  @impl true
  def handle_event("validate", %{"wishlist" => wishlist_params}, socket) do
    changeset = Accounts.change_wishlist(socket.assigns.wishlist, wishlist_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"wishlist" => wishlist_params}, socket) do
    save_wishlist(socket, socket.assigns.action, wishlist_params)
  end

  defp save_wishlist(socket, :edit, wishlist_params) do
    case Accounts.update_wishlist(socket.assigns.wishlist, wishlist_params) do
      {:ok, wishlist} ->
        notify_parent({:saved, wishlist})

        {:noreply,
         socket
         |> put_flash(:info, "Wishlist updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_wishlist(socket, :new, wishlist_params) do
    case Accounts.create_wishlist(wishlist_params) do
      {:ok, wishlist} ->
        notify_parent({:saved, wishlist})

        {:noreply,
         socket
         |> put_flash(:info, "Wishlist created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
