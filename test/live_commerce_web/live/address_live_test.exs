defmodule LiveCommerceWeb.AddressLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.AddressesFixtures

  @create_attrs %{title: "some title", address_line_1: "some address_line_1", address_line_2: "some address_line_2", country: "some country", city: "some city", postal_code: "some postal_code", landmark: "some landmark", phone_number: "some phone_number", deleted_at: "2024-10-30T04:47:00Z"}
  @update_attrs %{title: "some updated title", address_line_1: "some updated address_line_1", address_line_2: "some updated address_line_2", country: "some updated country", city: "some updated city", postal_code: "some updated postal_code", landmark: "some updated landmark", phone_number: "some updated phone_number", deleted_at: "2024-10-31T04:47:00Z"}
  @invalid_attrs %{title: nil, address_line_1: nil, address_line_2: nil, country: nil, city: nil, postal_code: nil, landmark: nil, phone_number: nil, deleted_at: nil}

  defp create_address(_) do
    address = address_fixture()
    %{address: address}
  end

  describe "Index" do
    setup [:create_address]

    test "lists all addresses", %{conn: conn, address: address} do
      {:ok, _index_live, html} = live(conn, ~p"/addresses")

      assert html =~ "Listing Addresses"
      assert html =~ address.title
    end

    test "saves new address", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("a", "New Address") |> render_click() =~
               "New Address"

      assert_patch(index_live, ~p"/addresses/new")

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#address-form", address: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/addresses")

      html = render(index_live)
      assert html =~ "Address created successfully"
      assert html =~ "some title"
    end

    test "updates address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("#addresses-#{address.id} a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(index_live, ~p"/addresses/#{address}/edit")

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#address-form", address: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/addresses")

      html = render(index_live)
      assert html =~ "Address updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("#addresses-#{address.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#addresses-#{address.id}")
    end
  end

  describe "Show" do
    setup [:create_address]

    test "displays address", %{conn: conn, address: address} do
      {:ok, _show_live, html} = live(conn, ~p"/addresses/#{address}")

      assert html =~ "Show Address"
      assert html =~ address.title
    end

    test "updates address within modal", %{conn: conn, address: address} do
      {:ok, show_live, _html} = live(conn, ~p"/addresses/#{address}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(show_live, ~p"/addresses/#{address}/show/edit")

      assert show_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#address-form", address: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/addresses/#{address}")

      html = render(show_live)
      assert html =~ "Address updated successfully"
      assert html =~ "some updated title"
    end
  end
end
