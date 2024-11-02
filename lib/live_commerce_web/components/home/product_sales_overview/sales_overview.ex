defmodule Home.Products.SalesOverview do
  use LiveCommerceWeb, :live_component

  alias LiveCommerce.Products

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{current_user: current_user}, socket) do
    %{current_month_start: current_month_start, current_month_end: current_month_end} =
      Utils.Date.get_current_month_start_end()

    %{last_month_start: last_month_start, last_month_end: last_month_end} =
      Utils.Date.get_last_month_start_end()

    most_sold_products =
      Products.list_most_sold_products_for_branch(
        current_user.branch_id,
        current_month_start,
        current_month_end
      )

    most_sold_products_json = Jason.encode!(most_sold_products)

    growth_rate =
      calculate_sales_growth(
        current_user.branch_id,
        current_month_start,
        current_month_end,
        last_month_start,
        last_month_end
      )

    socket =
      socket
      |> assign(:growth_rate, growth_rate)
      |> push_event("update_chart", %{data: most_sold_products_json})

    {:ok, socket}
  end

  defp calculate_sales_growth(
         branch_id,
         current_month_start,
         current_month_end,
         last_month_start,
         last_month_end
       ) do
    current_month_sales =
      Products.list_total_products_sales_for_branch(
        branch_id,
        current_month_start,
        current_month_end
      ) || 0

    last_month_sales =
      Products.list_total_products_sales_for_branch(
        branch_id,
        last_month_start,
        last_month_end
      ) || 0

    percentage_change =
      if last_month_sales > 0 do
        (current_month_sales - last_month_sales) / last_month_sales * 100
      else
        100.0
      end

    product_difference = current_month_sales - last_month_sales

    %{
      current_month: current_month_sales,
      last_month: last_month_sales,
      percentage_change: percentage_change,
      product_difference: product_difference
    }
  end
end
