defmodule LiveCommerceWeb.ProductCoverImageLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.ProductsFixtures

  @create_attrs %{cover: "some cover", deleted_at: "2024-10-30T04:44:00Z"}
  @update_attrs %{cover: "some updated cover", deleted_at: "2024-10-31T04:44:00Z"}
  @invalid_attrs %{cover: nil, deleted_at: nil}

  defp create_product_cover_image(_) do
    product_cover_image = product_cover_image_fixture()
    %{product_cover_image: product_cover_image}
  end

  describe "Index" do
    setup [:create_product_cover_image]

    test "lists all product_cover_images", %{conn: conn, product_cover_image: product_cover_image} do
      {:ok, _index_live, html} = live(conn, ~p"/product_cover_images")

      assert html =~ "Listing Product cover images"
      assert html =~ product_cover_image.cover
    end

    test "saves new product_cover_image", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/product_cover_images")

      assert index_live |> element("a", "New Product cover image") |> render_click() =~
               "New Product cover image"

      assert_patch(index_live, ~p"/product_cover_images/new")

      assert index_live
             |> form("#product_cover_image-form", product_cover_image: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_cover_image-form", product_cover_image: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/product_cover_images")

      html = render(index_live)
      assert html =~ "Product cover image created successfully"
      assert html =~ "some cover"
    end

    test "updates product_cover_image in listing", %{conn: conn, product_cover_image: product_cover_image} do
      {:ok, index_live, _html} = live(conn, ~p"/product_cover_images")

      assert index_live |> element("#product_cover_images-#{product_cover_image.id} a", "Edit") |> render_click() =~
               "Edit Product cover image"

      assert_patch(index_live, ~p"/product_cover_images/#{product_cover_image}/edit")

      assert index_live
             |> form("#product_cover_image-form", product_cover_image: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#product_cover_image-form", product_cover_image: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/product_cover_images")

      html = render(index_live)
      assert html =~ "Product cover image updated successfully"
      assert html =~ "some updated cover"
    end

    test "deletes product_cover_image in listing", %{conn: conn, product_cover_image: product_cover_image} do
      {:ok, index_live, _html} = live(conn, ~p"/product_cover_images")

      assert index_live |> element("#product_cover_images-#{product_cover_image.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product_cover_images-#{product_cover_image.id}")
    end
  end

  describe "Show" do
    setup [:create_product_cover_image]

    test "displays product_cover_image", %{conn: conn, product_cover_image: product_cover_image} do
      {:ok, _show_live, html} = live(conn, ~p"/product_cover_images/#{product_cover_image}")

      assert html =~ "Show Product cover image"
      assert html =~ product_cover_image.cover
    end

    test "updates product_cover_image within modal", %{conn: conn, product_cover_image: product_cover_image} do
      {:ok, show_live, _html} = live(conn, ~p"/product_cover_images/#{product_cover_image}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product cover image"

      assert_patch(show_live, ~p"/product_cover_images/#{product_cover_image}/show/edit")

      assert show_live
             |> form("#product_cover_image-form", product_cover_image: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#product_cover_image-form", product_cover_image: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/product_cover_images/#{product_cover_image}")

      html = render(show_live)
      assert html =~ "Product cover image updated successfully"
      assert html =~ "some updated cover"
    end
  end
end
