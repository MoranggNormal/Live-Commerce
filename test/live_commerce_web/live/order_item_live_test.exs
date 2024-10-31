defmodule LiveCommerceWeb.OrderItemLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.OrdersFixtures

  @create_attrs %{quantity: 42, deleted_at: "2024-10-30T04:50:00Z"}
  @update_attrs %{quantity: 43, deleted_at: "2024-10-31T04:50:00Z"}
  @invalid_attrs %{quantity: nil, deleted_at: nil}

  defp create_order_item(_) do
    order_item = order_item_fixture()
    %{order_item: order_item}
  end

  describe "Index" do
    setup [:create_order_item]

    test "lists all order_items", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/order_items")

      assert html =~ "Listing Order items"
    end

    test "saves new order_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/order_items")

      assert index_live |> element("a", "New Order item") |> render_click() =~
               "New Order item"

      assert_patch(index_live, ~p"/order_items/new")

      assert index_live
             |> form("#order_item-form", order_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#order_item-form", order_item: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/order_items")

      html = render(index_live)
      assert html =~ "Order item created successfully"
    end

    test "updates order_item in listing", %{conn: conn, order_item: order_item} do
      {:ok, index_live, _html} = live(conn, ~p"/order_items")

      assert index_live |> element("#order_items-#{order_item.id} a", "Edit") |> render_click() =~
               "Edit Order item"

      assert_patch(index_live, ~p"/order_items/#{order_item}/edit")

      assert index_live
             |> form("#order_item-form", order_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#order_item-form", order_item: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/order_items")

      html = render(index_live)
      assert html =~ "Order item updated successfully"
    end

    test "deletes order_item in listing", %{conn: conn, order_item: order_item} do
      {:ok, index_live, _html} = live(conn, ~p"/order_items")

      assert index_live |> element("#order_items-#{order_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#order_items-#{order_item.id}")
    end
  end

  describe "Show" do
    setup [:create_order_item]

    test "displays order_item", %{conn: conn, order_item: order_item} do
      {:ok, _show_live, html} = live(conn, ~p"/order_items/#{order_item}")

      assert html =~ "Show Order item"
    end

    test "updates order_item within modal", %{conn: conn, order_item: order_item} do
      {:ok, show_live, _html} = live(conn, ~p"/order_items/#{order_item}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Order item"

      assert_patch(show_live, ~p"/order_items/#{order_item}/show/edit")

      assert show_live
             |> form("#order_item-form", order_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#order_item-form", order_item: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/order_items/#{order_item}")

      html = render(show_live)
      assert html =~ "Order item updated successfully"
    end
  end
end
