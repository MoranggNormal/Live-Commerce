defmodule LiveCommerce.CartsTest do
  use LiveCommerce.DataCase

  alias LiveCommerce.Carts

  describe "carts" do
    alias LiveCommerce.Carts.Cart

    import LiveCommerce.CartsFixtures

    @invalid_attrs %{total: nil, deleted_at: nil}

    test "list_carts/0 returns all carts" do
      cart = cart_fixture()
      assert Carts.list_carts() == [cart]
    end

    test "get_cart!/1 returns the cart with given id" do
      cart = cart_fixture()
      assert Carts.get_cart!(cart.id) == cart
    end

    test "create_cart/1 with valid data creates a cart" do
      valid_attrs = %{total: 42, deleted_at: ~U[2024-10-30 04:47:00Z]}

      assert {:ok, %Cart{} = cart} = Carts.create_cart(valid_attrs)
      assert cart.total == 42
      assert cart.deleted_at == ~U[2024-10-30 04:47:00Z]
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Carts.create_cart(@invalid_attrs)
    end

    test "update_cart/2 with valid data updates the cart" do
      cart = cart_fixture()
      update_attrs = %{total: 43, deleted_at: ~U[2024-10-31 04:47:00Z]}

      assert {:ok, %Cart{} = cart} = Carts.update_cart(cart, update_attrs)
      assert cart.total == 43
      assert cart.deleted_at == ~U[2024-10-31 04:47:00Z]
    end

    test "update_cart/2 with invalid data returns error changeset" do
      cart = cart_fixture()
      assert {:error, %Ecto.Changeset{}} = Carts.update_cart(cart, @invalid_attrs)
      assert cart == Carts.get_cart!(cart.id)
    end

    test "delete_cart/1 deletes the cart" do
      cart = cart_fixture()
      assert {:ok, %Cart{}} = Carts.delete_cart(cart)
      assert_raise Ecto.NoResultsError, fn -> Carts.get_cart!(cart.id) end
    end

    test "change_cart/1 returns a cart changeset" do
      cart = cart_fixture()
      assert %Ecto.Changeset{} = Carts.change_cart(cart)
    end
  end

  describe "cart_items" do
    alias LiveCommerce.Carts.CartItem

    import LiveCommerce.CartsFixtures

    @invalid_attrs %{quantity: nil, deleted_at: nil}

    test "list_cart_items/0 returns all cart_items" do
      cart_item = cart_item_fixture()
      assert Carts.list_cart_items() == [cart_item]
    end

    test "get_cart_item!/1 returns the cart_item with given id" do
      cart_item = cart_item_fixture()
      assert Carts.get_cart_item!(cart_item.id) == cart_item
    end

    test "create_cart_item/1 with valid data creates a cart_item" do
      valid_attrs = %{quantity: 42, deleted_at: ~U[2024-10-30 04:48:00Z]}

      assert {:ok, %CartItem{} = cart_item} = Carts.create_cart_item(valid_attrs)
      assert cart_item.quantity == 42
      assert cart_item.deleted_at == ~U[2024-10-30 04:48:00Z]
    end

    test "create_cart_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Carts.create_cart_item(@invalid_attrs)
    end

    test "update_cart_item/2 with valid data updates the cart_item" do
      cart_item = cart_item_fixture()
      update_attrs = %{quantity: 43, deleted_at: ~U[2024-10-31 04:48:00Z]}

      assert {:ok, %CartItem{} = cart_item} = Carts.update_cart_item(cart_item, update_attrs)
      assert cart_item.quantity == 43
      assert cart_item.deleted_at == ~U[2024-10-31 04:48:00Z]
    end

    test "update_cart_item/2 with invalid data returns error changeset" do
      cart_item = cart_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Carts.update_cart_item(cart_item, @invalid_attrs)
      assert cart_item == Carts.get_cart_item!(cart_item.id)
    end

    test "delete_cart_item/1 deletes the cart_item" do
      cart_item = cart_item_fixture()
      assert {:ok, %CartItem{}} = Carts.delete_cart_item(cart_item)
      assert_raise Ecto.NoResultsError, fn -> Carts.get_cart_item!(cart_item.id) end
    end

    test "change_cart_item/1 returns a cart_item changeset" do
      cart_item = cart_item_fixture()
      assert %Ecto.Changeset{} = Carts.change_cart_item(cart_item)
    end
  end
end
