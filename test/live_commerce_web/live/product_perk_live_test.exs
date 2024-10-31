defmodule LiveCommerceWeb.ProductPerkLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.ProductsFixtures

  @create_attrs %{perk: "some perk", deleted_at: "2024-10-30T04:45:00Z"}
  @update_attrs %{perk: "some updated perk", deleted_at: "2024-10-31T04:45:00Z"}
  @invalid_attrs %{perk: nil, deleted_at: nil}

  defp create_product_perk(_) do
    product_perk = product_perk_fixture()
    %{product_perk: product_perk}
  end

  describe "Index" do
    setup [:create_product_perk]

    test "lists all product_perks", %{conn: conn, product_perk: product_perk} do
      {:ok, _index_live, html} = live(conn, ~p"/product_perks")

      assert html =~ "Listing Product perks"
      assert html =~ product_perk.perk
    end

    test "saves new product_perk", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/product_perks")

      assert index_live |> element("a", "New Product perk") |> render_click() =~
               "New Product perk"

      assert_patch(index_live, ~p"/product_perks/new")

      assert index_live
             |> form("#product_perk-form", product_perk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_perk-form", product_perk: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/product_perks")

      html = render(index_live)
      assert html =~ "Product perk created successfully"
      assert html =~ "some perk"
    end

    test "updates product_perk in listing", %{conn: conn, product_perk: product_perk} do
      {:ok, index_live, _html} = live(conn, ~p"/product_perks")

      assert index_live |> element("#product_perks-#{product_perk.id} a", "Edit") |> render_click() =~
               "Edit Product perk"

      assert_patch(index_live, ~p"/product_perks/#{product_perk}/edit")

      assert index_live
             |> form("#product_perk-form", product_perk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_perk-form", product_perk: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/product_perks")

      html = render(index_live)
      assert html =~ "Product perk updated successfully"
      assert html =~ "some updated perk"
    end

    test "deletes product_perk in listing", %{conn: conn, product_perk: product_perk} do
      {:ok, index_live, _html} = live(conn, ~p"/product_perks")

      assert index_live |> element("#product_perks-#{product_perk.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product_perks-#{product_perk.id}")
    end
  end

  describe "Show" do
    setup [:create_product_perk]

    test "displays product_perk", %{conn: conn, product_perk: product_perk} do
      {:ok, _show_live, html} = live(conn, ~p"/product_perks/#{product_perk}")

      assert html =~ "Show Product perk"
      assert html =~ product_perk.perk
    end

    test "updates product_perk within modal", %{conn: conn, product_perk: product_perk} do
      {:ok, show_live, _html} = live(conn, ~p"/product_perks/#{product_perk}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product perk"

      assert_patch(show_live, ~p"/product_perks/#{product_perk}/show/edit")

      assert show_live
             |> form("#product_perk-form", product_perk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#product_perk-form", product_perk: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/product_perks/#{product_perk}")

      html = render(show_live)
      assert html =~ "Product perk updated successfully"
      assert html =~ "some updated perk"
    end
  end
end
