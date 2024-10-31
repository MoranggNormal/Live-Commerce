defmodule LiveCommerceWeb.ProductCoverImageLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage product_cover_image records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="product_cover_image-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:cover]} type="text" label="Cover" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Product cover image</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{product_cover_image: product_cover_image} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Products.change_product_cover_image(product_cover_image))
     end)}
  end

  @impl true
  def handle_event("validate", %{"product_cover_image" => product_cover_image_params}, socket) do
    changeset = Products.change_product_cover_image(socket.assigns.product_cover_image, product_cover_image_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"product_cover_image" => product_cover_image_params}, socket) do
    save_product_cover_image(socket, socket.assigns.action, product_cover_image_params)
  end

  defp save_product_cover_image(socket, :edit, product_cover_image_params) do
    case Products.update_product_cover_image(socket.assigns.product_cover_image, product_cover_image_params) do
      {:ok, product_cover_image} ->
        notify_parent({:saved, product_cover_image})

        {:noreply,
         socket
         |> put_flash(:info, "Product cover image updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_product_cover_image(socket, :new, product_cover_image_params) do
    case Products.create_product_cover_image(product_cover_image_params) do
      {:ok, product_cover_image} ->
        notify_parent({:saved, product_cover_image})

        {:noreply,
         socket
         |> put_flash(:info, "Product cover image created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
