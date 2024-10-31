defmodule LiveCommerceWeb.ProductSKULiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.ProductsFixtures

  @create_attrs %{sku: "some sku", price: "some price", quantity: 42, published: true, deleted_at: "2024-10-30T04:43:00Z"}
  @update_attrs %{sku: "some updated sku", price: "some updated price", quantity: 43, published: false, deleted_at: "2024-10-31T04:43:00Z"}
  @invalid_attrs %{sku: nil, price: nil, quantity: nil, published: false, deleted_at: nil}

  defp create_product_sku(_) do
    product_sku = product_sku_fixture()
    %{product_sku: product_sku}
  end

  describe "Index" do
    setup [:create_product_sku]

    test "lists all products_skus", %{conn: conn, product_sku: product_sku} do
      {:ok, _index_live, html} = live(conn, ~p"/products_skus")

      assert html =~ "Listing Products skus"
      assert html =~ product_sku.sku
    end

    test "saves new product_sku", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/products_skus")

      assert index_live |> element("a", "New Product sku") |> render_click() =~
               "New Product sku"

      assert_patch(index_live, ~p"/products_skus/new")

      assert index_live
             |> form("#product_sku-form", product_sku: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_sku-form", product_sku: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/products_skus")

      html = render(index_live)
      assert html =~ "Product sku created successfully"
      assert html =~ "some sku"
    end

    test "updates product_sku in listing", %{conn: conn, product_sku: product_sku} do
      {:ok, index_live, _html} = live(conn, ~p"/products_skus")

      assert index_live |> element("#products_skus-#{product_sku.id} a", "Edit") |> render_click() =~
               "Edit Product sku"

      assert_patch(index_live, ~p"/products_skus/#{product_sku}/edit")

      assert index_live
             |> form("#product_sku-form", product_sku: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_sku-form", product_sku: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/products_skus")

      html = render(index_live)
      assert html =~ "Product sku updated successfully"
      assert html =~ "some updated sku"
    end

    test "deletes product_sku in listing", %{conn: conn, product_sku: product_sku} do
      {:ok, index_live, _html} = live(conn, ~p"/products_skus")

      assert index_live |> element("#products_skus-#{product_sku.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#products_skus-#{product_sku.id}")
    end
  end

  describe "Show" do
    setup [:create_product_sku]

    test "displays product_sku", %{conn: conn, product_sku: product_sku} do
      {:ok, _show_live, html} = live(conn, ~p"/products_skus/#{product_sku}")

      assert html =~ "Show Product sku"
      assert html =~ product_sku.sku
    end

    test "updates product_sku within modal", %{conn: conn, product_sku: product_sku} do
      {:ok, show_live, _html} = live(conn, ~p"/products_skus/#{product_sku}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product sku"

      assert_patch(show_live, ~p"/products_skus/#{product_sku}/show/edit")

      assert show_live
             |> form("#product_sku-form", product_sku: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#product_sku-form", product_sku: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/products_skus/#{product_sku}")

      html = render(show_live)
      assert html =~ "Product sku updated successfully"
      assert html =~ "some updated sku"
    end
  end
end
