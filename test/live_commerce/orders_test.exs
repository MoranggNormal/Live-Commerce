defmodule LiveCommerce.OrdersTest do
  use LiveCommerce.DataCase

  alias LiveCommerce.Orders

  describe "orders" do
    alias LiveCommerce.Orders.Order

    import LiveCommerce.OrdersFixtures

    @invalid_attrs %{status: nil, total: nil, payment_id: nil, deleted_at: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{status: "some status", total: 42, payment_id: 42, deleted_at: ~U[2024-10-30 04:50:00Z]}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.status == "some status"
      assert order.total == 42
      assert order.payment_id == 42
      assert order.deleted_at == ~U[2024-10-30 04:50:00Z]
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{status: "some updated status", total: 43, payment_id: 43, deleted_at: ~U[2024-10-31 04:50:00Z]}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.status == "some updated status"
      assert order.total == 43
      assert order.payment_id == 43
      assert order.deleted_at == ~U[2024-10-31 04:50:00Z]
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end

  describe "order_items" do
    alias LiveCommerce.Orders.OrderItem

    import LiveCommerce.OrdersFixtures

    @invalid_attrs %{quantity: nil, deleted_at: nil}

    test "list_order_items/0 returns all order_items" do
      order_item = order_item_fixture()
      assert Orders.list_order_items() == [order_item]
    end

    test "get_order_item!/1 returns the order_item with given id" do
      order_item = order_item_fixture()
      assert Orders.get_order_item!(order_item.id) == order_item
    end

    test "create_order_item/1 with valid data creates a order_item" do
      valid_attrs = %{quantity: 42, deleted_at: ~U[2024-10-30 04:50:00Z]}

      assert {:ok, %OrderItem{} = order_item} = Orders.create_order_item(valid_attrs)
      assert order_item.quantity == 42
      assert order_item.deleted_at == ~U[2024-10-30 04:50:00Z]
    end

    test "create_order_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order_item(@invalid_attrs)
    end

    test "update_order_item/2 with valid data updates the order_item" do
      order_item = order_item_fixture()
      update_attrs = %{quantity: 43, deleted_at: ~U[2024-10-31 04:50:00Z]}

      assert {:ok, %OrderItem{} = order_item} = Orders.update_order_item(order_item, update_attrs)
      assert order_item.quantity == 43
      assert order_item.deleted_at == ~U[2024-10-31 04:50:00Z]
    end

    test "update_order_item/2 with invalid data returns error changeset" do
      order_item = order_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order_item(order_item, @invalid_attrs)
      assert order_item == Orders.get_order_item!(order_item.id)
    end

    test "delete_order_item/1 deletes the order_item" do
      order_item = order_item_fixture()
      assert {:ok, %OrderItem{}} = Orders.delete_order_item(order_item)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order_item!(order_item.id) end
    end

    test "change_order_item/1 returns a order_item changeset" do
      order_item = order_item_fixture()
      assert %Ecto.Changeset{} = Orders.change_order_item(order_item)
    end
  end
end
