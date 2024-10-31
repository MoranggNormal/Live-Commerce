defmodule LiveCommerceWeb.ProductSKULive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage product_sku records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="product_sku-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:sku]} type="text" label="Sku" />
        <.input field={@form[:price]} type="text" label="Price" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:published]} type="checkbox" label="Published" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Product sku</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{product_sku: product_sku} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Products.change_product_sku(product_sku))
     end)}
  end

  @impl true
  def handle_event("validate", %{"product_sku" => product_sku_params}, socket) do
    changeset = Products.change_product_sku(socket.assigns.product_sku, product_sku_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"product_sku" => product_sku_params}, socket) do
    save_product_sku(socket, socket.assigns.action, product_sku_params)
  end

  defp save_product_sku(socket, :edit, product_sku_params) do
    case Products.update_product_sku(socket.assigns.product_sku, product_sku_params) do
      {:ok, product_sku} ->
        notify_parent({:saved, product_sku})

        {:noreply,
         socket
         |> put_flash(:info, "Product sku updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_product_sku(socket, :new, product_sku_params) do
    case Products.create_product_sku(product_sku_params) do
      {:ok, product_sku} ->
        notify_parent({:saved, product_sku})

        {:noreply,
         socket
         |> put_flash(:info, "Product sku created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
