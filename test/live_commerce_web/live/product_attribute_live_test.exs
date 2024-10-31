defmodule LiveCommerceWeb.ProductAttributeLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.ProductsFixtures

  @create_attrs %{attribute: %{}, deleted_at: "2024-10-30T04:45:00Z"}
  @update_attrs %{attribute: %{}, deleted_at: "2024-10-31T04:45:00Z"}
  @invalid_attrs %{attribute: nil, deleted_at: nil}

  defp create_product_attribute(_) do
    product_attribute = product_attribute_fixture()
    %{product_attribute: product_attribute}
  end

  describe "Index" do
    setup [:create_product_attribute]

    test "lists all product_attributes", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/product_attributes")

      assert html =~ "Listing Product attributes"
    end

    test "saves new product_attribute", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/product_attributes")

      assert index_live |> element("a", "New Product attribute") |> render_click() =~
               "New Product attribute"

      assert_patch(index_live, ~p"/product_attributes/new")

      assert index_live
             |> form("#product_attribute-form", product_attribute: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_attribute-form", product_attribute: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/product_attributes")

      html = render(index_live)
      assert html =~ "Product attribute created successfully"
    end

    test "updates product_attribute in listing", %{conn: conn, product_attribute: product_attribute} do
      {:ok, index_live, _html} = live(conn, ~p"/product_attributes")

      assert index_live |> element("#product_attributes-#{product_attribute.id} a", "Edit") |> render_click() =~
               "Edit Product attribute"

      assert_patch(index_live, ~p"/product_attributes/#{product_attribute}/edit")

      assert index_live
             |> form("#product_attribute-form", product_attribute: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_attribute-form", product_attribute: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/product_attributes")

      html = render(index_live)
      assert html =~ "Product attribute updated successfully"
    end

    test "deletes product_attribute in listing", %{conn: conn, product_attribute: product_attribute} do
      {:ok, index_live, _html} = live(conn, ~p"/product_attributes")

      assert index_live |> element("#product_attributes-#{product_attribute.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product_attributes-#{product_attribute.id}")
    end
  end

  describe "Show" do
    setup [:create_product_attribute]

    test "displays product_attribute", %{conn: conn, product_attribute: product_attribute} do
      {:ok, _show_live, html} = live(conn, ~p"/product_attributes/#{product_attribute}")

      assert html =~ "Show Product attribute"
    end

    test "updates product_attribute within modal", %{conn: conn, product_attribute: product_attribute} do
      {:ok, show_live, _html} = live(conn, ~p"/product_attributes/#{product_attribute}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product attribute"

      assert_patch(show_live, ~p"/product_attributes/#{product_attribute}/show/edit")

      assert show_live
             |> form("#product_attribute-form", product_attribute: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#product_attribute-form", product_attribute: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/product_attributes/#{product_attribute}")

      html = render(show_live)
      assert html =~ "Product attribute updated successfully"
    end
  end
end
