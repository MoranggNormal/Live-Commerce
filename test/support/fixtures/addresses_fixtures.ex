defmodule LiveCommerce.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCommerce.Addresses` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        address_line_1: "some address_line_1",
        address_line_2: "some address_line_2",
        city: "some city",
        country: "some country",
        deleted_at: ~U[2024-10-30 04:47:00Z],
        landmark: "some landmark",
        phone_number: "some phone_number",
        postal_code: "some postal_code",
        title: "some title"
      })
      |> LiveCommerce.Addresses.create_address()

    address
  end
end
