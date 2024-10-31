defmodule LiveCommerceWeb.WishlistLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.AccountsFixtures

  @create_attrs %{deleted_at: "2024-10-30T04:48:00Z"}
  @update_attrs %{deleted_at: "2024-10-31T04:48:00Z"}
  @invalid_attrs %{deleted_at: nil}

  defp create_wishlist(_) do
    wishlist = wishlist_fixture()
    %{wishlist: wishlist}
  end

  describe "Index" do
    setup [:create_wishlist]

    test "lists all wishlists", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/wishlists")

      assert html =~ "Listing Wishlists"
    end

    test "saves new wishlist", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/wishlists")

      assert index_live |> element("a", "New Wishlist") |> render_click() =~
               "New Wishlist"

      assert_patch(index_live, ~p"/wishlists/new")

      assert index_live
             |> form("#wishlist-form", wishlist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#wishlist-form", wishlist: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/wishlists")

      html = render(index_live)
      assert html =~ "Wishlist created successfully"
    end

    test "updates wishlist in listing", %{conn: conn, wishlist: wishlist} do
      {:ok, index_live, _html} = live(conn, ~p"/wishlists")

      assert index_live |> element("#wishlists-#{wishlist.id} a", "Edit") |> render_click() =~
               "Edit Wishlist"

      assert_patch(index_live, ~p"/wishlists/#{wishlist}/edit")

      assert index_live
             |> form("#wishlist-form", wishlist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#wishlist-form", wishlist: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/wishlists")

      html = render(index_live)
      assert html =~ "Wishlist updated successfully"
    end

    test "deletes wishlist in listing", %{conn: conn, wishlist: wishlist} do
      {:ok, index_live, _html} = live(conn, ~p"/wishlists")

      assert index_live |> element("#wishlists-#{wishlist.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#wishlists-#{wishlist.id}")
    end
  end

  describe "Show" do
    setup [:create_wishlist]

    test "displays wishlist", %{conn: conn, wishlist: wishlist} do
      {:ok, _show_live, html} = live(conn, ~p"/wishlists/#{wishlist}")

      assert html =~ "Show Wishlist"
    end

    test "updates wishlist within modal", %{conn: conn, wishlist: wishlist} do
      {:ok, show_live, _html} = live(conn, ~p"/wishlists/#{wishlist}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Wishlist"

      assert_patch(show_live, ~p"/wishlists/#{wishlist}/show/edit")

      assert show_live
             |> form("#wishlist-form", wishlist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#wishlist-form", wishlist: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/wishlists/#{wishlist}")

      html = render(show_live)
      assert html =~ "Wishlist updated successfully"
    end
  end
end
