defmodule LiveCommerce.PaymentsTest do
  use LiveCommerce.DataCase

  alias LiveCommerce.Payments

  describe "payments" do
    alias LiveCommerce.Payments.Payment

    import LiveCommerce.PaymentsFixtures

    @invalid_attrs %{status: nil, provider: nil, amount: nil}

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Payments.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Payments.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      valid_attrs = %{status: "some status", provider: "some provider", amount: 42}

      assert {:ok, %Payment{} = payment} = Payments.create_payment(valid_attrs)
      assert payment.status == "some status"
      assert payment.provider == "some provider"
      assert payment.amount == 42
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payments.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      update_attrs = %{status: "some updated status", provider: "some updated provider", amount: 43}

      assert {:ok, %Payment{} = payment} = Payments.update_payment(payment, update_attrs)
      assert payment.status == "some updated status"
      assert payment.provider == "some updated provider"
      assert payment.amount == 43
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Payments.update_payment(payment, @invalid_attrs)
      assert payment == Payments.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Payments.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Payments.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Payments.change_payment(payment)
    end
  end
end
