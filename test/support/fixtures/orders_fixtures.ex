defmodule LiveCommerce.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCommerce.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:50:00Z],
        payment_id: 42,
        status: "some status",
        total: 42
      })
      |> LiveCommerce.Orders.create_order()

    order
  end

  @doc """
  Generate a order_item.
  """
  def order_item_fixture(attrs \\ %{}) do
    {:ok, order_item} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:50:00Z],
        quantity: 42
      })
      |> LiveCommerce.Orders.create_order_item()

    order_item
  end
end
