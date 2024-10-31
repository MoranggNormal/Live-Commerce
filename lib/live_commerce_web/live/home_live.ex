defmodule LiveCommerceWeb.HomeLive do
  use LiveCommerceWeb, :live_view

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user

    socket =
      socket
      |> assign(:current_user, user)

    {:ok, socket}
  end
end
