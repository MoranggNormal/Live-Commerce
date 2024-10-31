defmodule LiveCommerceWeb.BranchLive.Index do
  use LiveCommerceWeb, :live_view

  alias LiveCommerce.Branches
  alias LiveCommerce.Branches.Branch

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :branches, Branches.list_branches())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Branch")
    |> assign(:branch, Branches.get_branch!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Branch")
    |> assign(:branch, %Branch{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Branches")
    |> assign(:branch, nil)
  end

  @impl true
  def handle_info({LiveCommerceWeb.BranchLive.FormComponent, {:saved, branch}}, socket) do
    {:noreply, stream_insert(socket, :branches, branch)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    branch = Branches.get_branch!(id)
    {:ok, _} = Branches.delete_branch(branch)

    {:noreply, stream_delete(socket, :branches, branch)}
  end
end
