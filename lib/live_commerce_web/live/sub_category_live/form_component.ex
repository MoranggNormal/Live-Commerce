defmodule LiveCommerceWeb.SubCategoryLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage sub_category records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="sub_category-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Sub category</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{sub_category: sub_category} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Products.change_sub_category(sub_category))
     end)}
  end

  @impl true
  def handle_event("validate", %{"sub_category" => sub_category_params}, socket) do
    changeset = Products.change_sub_category(socket.assigns.sub_category, sub_category_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"sub_category" => sub_category_params}, socket) do
    save_sub_category(socket, socket.assigns.action, sub_category_params)
  end

  defp save_sub_category(socket, :edit, sub_category_params) do
    case Products.update_sub_category(socket.assigns.sub_category, sub_category_params) do
      {:ok, sub_category} ->
        notify_parent({:saved, sub_category})

        {:noreply,
         socket
         |> put_flash(:info, "Sub category updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_sub_category(socket, :new, sub_category_params) do
    case Products.create_sub_category(sub_category_params) do
      {:ok, sub_category} ->
        notify_parent({:saved, sub_category})

        {:noreply,
         socket
         |> put_flash(:info, "Sub category created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
