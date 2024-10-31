defmodule LiveCommerce.AddressesTest do
  use LiveCommerce.DataCase

  alias LiveCommerce.Addresses

  describe "addresses" do
    alias LiveCommerce.Addresses.Address

    import LiveCommerce.AddressesFixtures

    @invalid_attrs %{title: nil, address_line_1: nil, address_line_2: nil, country: nil, city: nil, postal_code: nil, landmark: nil, phone_number: nil, deleted_at: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{title: "some title", address_line_1: "some address_line_1", address_line_2: "some address_line_2", country: "some country", city: "some city", postal_code: "some postal_code", landmark: "some landmark", phone_number: "some phone_number", deleted_at: ~U[2024-10-30 04:47:00Z]}

      assert {:ok, %Address{} = address} = Addresses.create_address(valid_attrs)
      assert address.title == "some title"
      assert address.address_line_1 == "some address_line_1"
      assert address.address_line_2 == "some address_line_2"
      assert address.country == "some country"
      assert address.city == "some city"
      assert address.postal_code == "some postal_code"
      assert address.landmark == "some landmark"
      assert address.phone_number == "some phone_number"
      assert address.deleted_at == ~U[2024-10-30 04:47:00Z]
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{title: "some updated title", address_line_1: "some updated address_line_1", address_line_2: "some updated address_line_2", country: "some updated country", city: "some updated city", postal_code: "some updated postal_code", landmark: "some updated landmark", phone_number: "some updated phone_number", deleted_at: ~U[2024-10-31 04:47:00Z]}

      assert {:ok, %Address{} = address} = Addresses.update_address(address, update_attrs)
      assert address.title == "some updated title"
      assert address.address_line_1 == "some updated address_line_1"
      assert address.address_line_2 == "some updated address_line_2"
      assert address.country == "some updated country"
      assert address.city == "some updated city"
      assert address.postal_code == "some updated postal_code"
      assert address.landmark == "some updated landmark"
      assert address.phone_number == "some updated phone_number"
      assert address.deleted_at == ~U[2024-10-31 04:47:00Z]
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(address, @invalid_attrs)
      assert address == Addresses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
