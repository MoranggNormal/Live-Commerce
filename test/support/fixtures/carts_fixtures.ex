defmodule LiveCommerce.CartsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCommerce.Carts` context.
  """

  @doc """
  Generate a cart.
  """
  def cart_fixture(attrs \\ %{}) do
    {:ok, cart} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:47:00Z],
        total: 42
      })
      |> LiveCommerce.Carts.create_cart()

    cart
  end

  @doc """
  Generate a cart_item.
  """
  def cart_item_fixture(attrs \\ %{}) do
    {:ok, cart_item} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:48:00Z],
        quantity: 42
      })
      |> LiveCommerce.Carts.create_cart_item()

    cart_item
  end
end
