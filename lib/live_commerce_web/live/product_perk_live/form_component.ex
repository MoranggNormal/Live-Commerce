defmodule LiveCommerceWeb.ProductPerkLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage product_perk records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="product_perk-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:perk]} type="text" label="Perk" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Product perk</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{product_perk: product_perk} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Products.change_product_perk(product_perk))
     end)}
  end

  @impl true
  def handle_event("validate", %{"product_perk" => product_perk_params}, socket) do
    changeset = Products.change_product_perk(socket.assigns.product_perk, product_perk_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"product_perk" => product_perk_params}, socket) do
    save_product_perk(socket, socket.assigns.action, product_perk_params)
  end

  defp save_product_perk(socket, :edit, product_perk_params) do
    case Products.update_product_perk(socket.assigns.product_perk, product_perk_params) do
      {:ok, product_perk} ->
        notify_parent({:saved, product_perk})

        {:noreply,
         socket
         |> put_flash(:info, "Product perk updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_product_perk(socket, :new, product_perk_params) do
    case Products.create_product_perk(product_perk_params) do
      {:ok, product_perk} ->
        notify_parent({:saved, product_perk})

        {:noreply,
         socket
         |> put_flash(:info, "Product perk created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end