defmodule LiveCommerceWeb.BranchLive.FormComponent do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Branches

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage branch records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="branch-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:subdomain]} type="text" label="Subdomain" />
        <.input field={@form[:parent_branch_id]} type="number" label="Parent branch" />
        <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Branch</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{branch: branch} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Branches.change_branch(branch))
     end)}
  end

  @impl true
  def handle_event("validate", %{"branch" => branch_params}, socket) do
    changeset = Branches.change_branch(socket.assigns.branch, branch_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"branch" => branch_params}, socket) do
    save_branch(socket, socket.assigns.action, branch_params)
  end

  defp save_branch(socket, :edit, branch_params) do
    case Branches.update_branch(socket.assigns.branch, branch_params) do
      {:ok, branch} ->
        notify_parent({:saved, branch})

        {:noreply,
         socket
         |> put_flash(:info, "Branch updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_branch(socket, :new, branch_params) do
    case Branches.create_branch(branch_params) do
      {:ok, branch} ->
        notify_parent({:saved, branch})

        {:noreply,
         socket
         |> put_flash(:info, "Branch created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
