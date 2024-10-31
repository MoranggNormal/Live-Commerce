defmodule LiveCommerceWeb.ItemModelLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.ProductsFixtures

  @create_attrs %{value: %{}, deleted_at: "2024-10-30T04:46:00Z"}
  @update_attrs %{value: %{}, deleted_at: "2024-10-31T04:46:00Z"}
  @invalid_attrs %{value: nil, deleted_at: nil}

  defp create_item_model(_) do
    item_model = item_model_fixture()
    %{item_model: item_model}
  end

  describe "Index" do
    setup [:create_item_model]

    test "lists all item_models", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/item_models")

      assert html =~ "Listing Item models"
    end

    test "saves new item_model", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/item_models")

      assert index_live |> element("a", "New Item model") |> render_click() =~
               "New Item model"

      assert_patch(index_live, ~p"/item_models/new")

      assert index_live
             |> form("#item_model-form", item_model: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#item_model-form", item_model: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/item_models")

      html = render(index_live)
      assert html =~ "Item model created successfully"
    end

    test "updates item_model in listing", %{conn: conn, item_model: item_model} do
      {:ok, index_live, _html} = live(conn, ~p"/item_models")

      assert index_live |> element("#item_models-#{item_model.id} a", "Edit") |> render_click() =~
               "Edit Item model"

      assert_patch(index_live, ~p"/item_models/#{item_model}/edit")

      assert index_live
             |> form("#item_model-form", item_model: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#item_model-form", item_model: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/item_models")

      html = render(index_live)
      assert html =~ "Item model updated successfully"
    end

    test "deletes item_model in listing", %{conn: conn, item_model: item_model} do
      {:ok, index_live, _html} = live(conn, ~p"/item_models")

      assert index_live |> element("#item_models-#{item_model.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#item_models-#{item_model.id}")
    end
  end

  describe "Show" do
    setup [:create_item_model]

    test "displays item_model", %{conn: conn, item_model: item_model} do
      {:ok, _show_live, html} = live(conn, ~p"/item_models/#{item_model}")

      assert html =~ "Show Item model"
    end

    test "updates item_model within modal", %{conn: conn, item_model: item_model} do
      {:ok, show_live, _html} = live(conn, ~p"/item_models/#{item_model}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Item model"

      assert_patch(show_live, ~p"/item_models/#{item_model}/show/edit")

      assert show_live
             |> form("#item_model-form", item_model: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#item_model-form", item_model: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/item_models/#{item_model}")

      html = render(show_live)
      assert html =~ "Item model updated successfully"
    end
  end
end
