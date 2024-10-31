defmodule LiveCommerceWeb.ClassificationLiveTest do
  use LiveCommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCommerce.ProductsFixtures

  @create_attrs %{name: "some name", deleted_at: "2024-10-30T04:42:00Z"}
  @update_attrs %{name: "some updated name", deleted_at: "2024-10-31T04:42:00Z"}
  @invalid_attrs %{name: nil, deleted_at: nil}

  defp create_classification(_) do
    classification = classification_fixture()
    %{classification: classification}
  end

  describe "Index" do
    setup [:create_classification]

    test "lists all classifications", %{conn: conn, classification: classification} do
      {:ok, _index_live, html} = live(conn, ~p"/classifications")

      assert html =~ "Listing Classifications"
      assert html =~ classification.name
    end

    test "saves new classification", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/classifications")

      assert index_live |> element("a", "New Classification") |> render_click() =~
               "New Classification"

      assert_patch(index_live, ~p"/classifications/new")

      assert index_live
             |> form("#classification-form", classification: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#classification-form", classification: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/classifications")

      html = render(index_live)
      assert html =~ "Classification created successfully"
      assert html =~ "some name"
    end

    test "updates classification in listing", %{conn: conn, classification: classification} do
      {:ok, index_live, _html} = live(conn, ~p"/classifications")

      assert index_live |> element("#classifications-#{classification.id} a", "Edit") |> render_click() =~
               "Edit Classification"

      assert_patch(index_live, ~p"/classifications/#{classification}/edit")

      assert index_live
             |> form("#classification-form", classification: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#classification-form", classification: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/classifications")

      html = render(index_live)
      assert html =~ "Classification updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes classification in listing", %{conn: conn, classification: classification} do
      {:ok, index_live, _html} = live(conn, ~p"/classifications")

      assert index_live |> element("#classifications-#{classification.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#classifications-#{classification.id}")
    end
  end

  describe "Show" do
    setup [:create_classification]

    test "displays classification", %{conn: conn, classification: classification} do
      {:ok, _show_live, html} = live(conn, ~p"/classifications/#{classification}")

      assert html =~ "Show Classification"
      assert html =~ classification.name
    end

    test "updates classification within modal", %{conn: conn, classification: classification} do
      {:ok, show_live, _html} = live(conn, ~p"/classifications/#{classification}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Classification"

      assert_patch(show_live, ~p"/classifications/#{classification}/show/edit")

      assert show_live
             |> form("#classification-form", classification: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#classification-form", classification: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/classifications/#{classification}")

      html = render(show_live)
      assert html =~ "Classification updated successfully"
      assert html =~ "some updated name"
    end
  end
end
