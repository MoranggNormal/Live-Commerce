defmodule LiveCommerce.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCommerce.Products` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        created_at: ~U[2024-10-30 04:41:00Z],
        deleted_at: ~U[2024-10-30 04:41:00Z],
        description: "some description",
        name: "some name",
        updated_at: ~U[2024-10-30 04:41:00Z]
      })
      |> LiveCommerce.Products.create_category()

    category
  end

  @doc """
  Generate a classification.
  """
  def classification_fixture(attrs \\ %{}) do
    {:ok, classification} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:42:00Z],
        name: "some name"
      })
      |> LiveCommerce.Products.create_classification()

    classification
  end

  @doc """
  Generate a sub_category.
  """
  def sub_category_fixture(attrs \\ %{}) do
    {:ok, sub_category} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:43:00Z],
        description: "some description",
        name: "some name"
      })
      |> LiveCommerce.Products.create_sub_category()

    sub_category
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:43:00Z],
        description: "some description",
        name: "some name"
      })
      |> LiveCommerce.Products.create_product()

    product
  end

  @doc """
  Generate a product_sku.
  """
  def product_sku_fixture(attrs \\ %{}) do
    {:ok, product_sku} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:43:00Z],
        price: "some price",
        published: true,
        quantity: 42,
        sku: "some sku"
      })
      |> LiveCommerce.Products.create_product_sku()

    product_sku
  end

  @doc """
  Generate a product_cover_image.
  """
  def product_cover_image_fixture(attrs \\ %{}) do
    {:ok, product_cover_image} =
      attrs
      |> Enum.into(%{
        cover: "some cover",
        deleted_at: ~U[2024-10-30 04:44:00Z]
      })
      |> LiveCommerce.Products.create_product_cover_image()

    product_cover_image
  end

  @doc """
  Generate a product_perk.
  """
  def product_perk_fixture(attrs \\ %{}) do
    {:ok, product_perk} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:45:00Z],
        perk: "some perk"
      })
      |> LiveCommerce.Products.create_product_perk()

    product_perk
  end

  @doc """
  Generate a product_attribute.
  """
  def product_attribute_fixture(attrs \\ %{}) do
    {:ok, product_attribute} =
      attrs
      |> Enum.into(%{
        attribute: %{},
        deleted_at: ~U[2024-10-30 04:45:00Z]
      })
      |> LiveCommerce.Products.create_product_attribute()

    product_attribute
  end

  @doc """
  Generate a item_model.
  """
  def item_model_fixture(attrs \\ %{}) do
    {:ok, item_model} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:46:00Z],
        value: %{}
      })
      |> LiveCommerce.Products.create_item_model()

    item_model
  end
end
