defmodule LiveCommerceWeb.SubCategoryLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.ProductsFixtures

  @create_attrs %{name: "some name", description: "some description", deleted_at: "2024-10-30T04:43:00Z"}
  @update_attrs %{name: "some updated name", description: "some updated description", deleted_at: "2024-10-31T04:43:00Z"}
  @invalid_attrs %{name: nil, description: nil, deleted_at: nil}

  defp create_sub_category(_) do
    sub_category = sub_category_fixture()
    %{sub_category: sub_category}
  end

  describe "Index" do
    setup [:create_sub_category]

    test "lists all sub_categories", %{conn: conn, sub_category: sub_category} do
      {:ok, _index_live, html} = live(conn, ~p"/sub_categories")

      assert html =~ "Listing Sub categories"
      assert html =~ sub_category.name
    end

    test "saves new sub_category", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_categories")

      assert index_live |> element("a", "New Sub category") |> render_click() =~
               "New Sub category"

      assert_patch(index_live, ~p"/sub_categories/new")

      assert index_live
             |> form("#sub_category-form", sub_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sub_category-form", sub_category: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sub_categories")

      html = render(index_live)
      assert html =~ "Sub category created successfully"
      assert html =~ "some name"
    end

    test "updates sub_category in listing", %{conn: conn, sub_category: sub_category} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_categories")

      assert index_live |> element("#sub_categories-#{sub_category.id} a", "Edit") |> render_click() =~
               "Edit Sub category"

      assert_patch(index_live, ~p"/sub_categories/#{sub_category}/edit")

      assert index_live
             |> form("#sub_category-form", sub_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sub_category-form", sub_category: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sub_categories")

      html = render(index_live)
      assert html =~ "Sub category updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes sub_category in listing", %{conn: conn, sub_category: sub_category} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_categories")

      assert index_live |> element("#sub_categories-#{sub_category.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sub_categories-#{sub_category.id}")
    end
  end

  describe "Show" do
    setup [:create_sub_category]

    test "displays sub_category", %{conn: conn, sub_category: sub_category} do
      {:ok, _show_live, html} = live(conn, ~p"/sub_categories/#{sub_category}")

      assert html =~ "Show Sub category"
      assert html =~ sub_category.name
    end

    test "updates sub_category within modal", %{conn: conn, sub_category: sub_category} do
      {:ok, show_live, _html} = live(conn, ~p"/sub_categories/#{sub_category}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sub category"

      assert_patch(show_live, ~p"/sub_categories/#{sub_category}/show/edit")

      assert show_live
             |> form("#sub_category-form", sub_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#sub_category-form", sub_category: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/sub_categories/#{sub_category}")

      html = render(show_live)
      assert html =~ "Sub category updated successfully"
      assert html =~ "some updated name"
    end
  end
end
