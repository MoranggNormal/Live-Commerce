defmodule Home.DailyResume do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Orders
  alias LiveCommerce.Products

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{current_user: current_user}, socket) do
    today = Date.utc_today()

    today_orders_count = Orders.from_date_count_orders_for_branch(today, current_user.branch_id)
    today_paid_orders_count = Orders.from_date_count_paid_orders_for_branch(today, current_user.branch_id)

    products_count = Products.count_products_for_branch(current_user.branch_id)

    socket =
      socket
      |> assign(:today_orders_count, today_orders_count)
      |> assign(:today_paid_orders_count, today_paid_orders_count)
      |> assign(:products_count, products_count)

    {:ok, socket}
  end
end
