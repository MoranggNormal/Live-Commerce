defmodule Home.General do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Orders
  alias LiveCommerce.Products

  def mount(_params, socket) do
    {:ok, socket}
  end

  def update(%{current_user: current_user}, socket) do
    orders_count = Orders.count_orders_for_branch(current_user.branch_id)
    paid_orders_count = Orders.count_paid_orders_for_branch(current_user.branch_id)

    products_count = Products.count_products_for_branch(current_user.branch_id)

    socket =
      socket
      |> assign(:orders_count, orders_count)
      |> assign(:paid_orders_count, paid_orders_count)
      |> assign(:products_count, products_count)

    {:ok, socket}
  end
end
