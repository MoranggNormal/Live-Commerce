defmodule LiveCommerce.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCommerce.Payments` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        amount: 42,
        provider: "some provider",
        status: "some status"
      })
      |> LiveCommerce.Payments.create_payment()

    payment
  end
end
