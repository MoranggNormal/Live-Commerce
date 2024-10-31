defmodule LiveCommerceWeb.ProductAttributeLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage product_attribute records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="product_attribute-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Product attribute</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{product_attribute: product_attribute} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Products.change_product_attribute(product_attribute))
     end)}
  end

  @impl true
  def handle_event("validate", %{"product_attribute" => product_attribute_params}, socket) do
    changeset = Products.change_product_attribute(socket.assigns.product_attribute, product_attribute_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"product_attribute" => product_attribute_params}, socket) do
    save_product_attribute(socket, socket.assigns.action, product_attribute_params)
  end

  defp save_product_attribute(socket, :edit, product_attribute_params) do
    case Products.update_product_attribute(socket.assigns.product_attribute, product_attribute_params) do
      {:ok, product_attribute} ->
        notify_parent({:saved, product_attribute})

        {:noreply,
         socket
         |> put_flash(:info, "Product attribute updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_product_attribute(socket, :new, product_attribute_params) do
    case Products.create_product_attribute(product_attribute_params) do
      {:ok, product_attribute} ->
        notify_parent({:saved, product_attribute})

        {:noreply,
         socket
         |> put_flash(:info, "Product attribute created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
