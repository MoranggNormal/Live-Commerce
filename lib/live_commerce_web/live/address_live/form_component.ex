defmodule LiveCommerceWeb.AddressLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Addresses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage address records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="address-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:address_line_1]} type="text" label="Address line 1" />
        <.input field={@form[:address_line_2]} type="text" label="Address line 2" />
        <.input field={@form[:country]} type="text" label="Country" />
        <.input field={@form[:city]} type="text" label="City" />
        <.input field={@form[:postal_code]} type="text" label="Postal code" />
        <.input field={@form[:landmark]} type="text" label="Landmark" />
        <.input field={@form[:phone_number]} type="text" label="Phone number" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Address</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{address: address} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Addresses.change_address(address))
     end)}
  end

  @impl true
  def handle_event("validate", %{"address" => address_params}, socket) do
    changeset = Addresses.change_address(socket.assigns.address, address_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"address" => address_params}, socket) do
    save_address(socket, socket.assigns.action, address_params)
  end

  defp save_address(socket, :edit, address_params) do
    case Addresses.update_address(socket.assigns.address, address_params) do
      {:ok, address} ->
        notify_parent({:saved, address})

        {:noreply,
         socket
         |> put_flash(:info, "Address updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_address(socket, :new, address_params) do
    case Addresses.create_address(address_params) do
      {:ok, address} ->
        notify_parent({:saved, address})

        {:noreply,
         socket
         |> put_flash(:info, "Address created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
