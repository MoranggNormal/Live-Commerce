defmodule LiveCommerce.ProductsTest do
  use LiveCommerce.DataCase

  alias LiveCommerce.Products

  describe "categories" do
    alias LiveCommerce.Products.Category

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{name: nil, description: nil, created_at: nil, updated_at: nil, deleted_at: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Products.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Products.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name", description: "some description", created_at: ~U[2024-10-30 04:41:00Z], updated_at: ~U[2024-10-30 04:41:00Z], deleted_at: ~U[2024-10-30 04:41:00Z]}

      assert {:ok, %Category{} = category} = Products.create_category(valid_attrs)
      assert category.name == "some name"
      assert category.description == "some description"
      assert category.created_at == ~U[2024-10-30 04:41:00Z]
      assert category.updated_at == ~U[2024-10-30 04:41:00Z]
      assert category.deleted_at == ~U[2024-10-30 04:41:00Z]
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", created_at: ~U[2024-10-31 04:41:00Z], updated_at: ~U[2024-10-31 04:41:00Z], deleted_at: ~U[2024-10-31 04:41:00Z]}

      assert {:ok, %Category{} = category} = Products.update_category(category, update_attrs)
      assert category.name == "some updated name"
      assert category.description == "some updated description"
      assert category.created_at == ~U[2024-10-31 04:41:00Z]
      assert category.updated_at == ~U[2024-10-31 04:41:00Z]
      assert category.deleted_at == ~U[2024-10-31 04:41:00Z]
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_category(category, @invalid_attrs)
      assert category == Products.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Products.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Products.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Products.change_category(category)
    end
  end

  describe "classifications" do
    alias LiveCommerce.Products.Classification

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{name: nil, deleted_at: nil}

    test "list_classifications/0 returns all classifications" do
      classification = classification_fixture()
      assert Products.list_classifications() == [classification]
    end

    test "get_classification!/1 returns the classification with given id" do
      classification = classification_fixture()
      assert Products.get_classification!(classification.id) == classification
    end

    test "create_classification/1 with valid data creates a classification" do
      valid_attrs = %{name: "some name", deleted_at: ~U[2024-10-30 04:42:00Z]}

      assert {:ok, %Classification{} = classification} = Products.create_classification(valid_attrs)
      assert classification.name == "some name"
      assert classification.deleted_at == ~U[2024-10-30 04:42:00Z]
    end

    test "create_classification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_classification(@invalid_attrs)
    end

    test "update_classification/2 with valid data updates the classification" do
      classification = classification_fixture()
      update_attrs = %{name: "some updated name", deleted_at: ~U[2024-10-31 04:42:00Z]}

      assert {:ok, %Classification{} = classification} = Products.update_classification(classification, update_attrs)
      assert classification.name == "some updated name"
      assert classification.deleted_at == ~U[2024-10-31 04:42:00Z]
    end

    test "update_classification/2 with invalid data returns error changeset" do
      classification = classification_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_classification(classification, @invalid_attrs)
      assert classification == Products.get_classification!(classification.id)
    end

    test "delete_classification/1 deletes the classification" do
      classification = classification_fixture()
      assert {:ok, %Classification{}} = Products.delete_classification(classification)
      assert_raise Ecto.NoResultsError, fn -> Products.get_classification!(classification.id) end
    end

    test "change_classification/1 returns a classification changeset" do
      classification = classification_fixture()
      assert %Ecto.Changeset{} = Products.change_classification(classification)
    end
  end

  describe "sub_categories" do
    alias LiveCommerce.Products.SubCategory

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{name: nil, description: nil, deleted_at: nil}

    test "list_sub_categories/0 returns all sub_categories" do
      sub_category = sub_category_fixture()
      assert Products.list_sub_categories() == [sub_category]
    end

    test "get_sub_category!/1 returns the sub_category with given id" do
      sub_category = sub_category_fixture()
      assert Products.get_sub_category!(sub_category.id) == sub_category
    end

    test "create_sub_category/1 with valid data creates a sub_category" do
      valid_attrs = %{name: "some name", description: "some description", deleted_at: ~U[2024-10-30 04:43:00Z]}

      assert {:ok, %SubCategory{} = sub_category} = Products.create_sub_category(valid_attrs)
      assert sub_category.name == "some name"
      assert sub_category.description == "some description"
      assert sub_category.deleted_at == ~U[2024-10-30 04:43:00Z]
    end

    test "create_sub_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_sub_category(@invalid_attrs)
    end

    test "update_sub_category/2 with valid data updates the sub_category" do
      sub_category = sub_category_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", deleted_at: ~U[2024-10-31 04:43:00Z]}

      assert {:ok, %SubCategory{} = sub_category} = Products.update_sub_category(sub_category, update_attrs)
      assert sub_category.name == "some updated name"
      assert sub_category.description == "some updated description"
      assert sub_category.deleted_at == ~U[2024-10-31 04:43:00Z]
    end

    test "update_sub_category/2 with invalid data returns error changeset" do
      sub_category = sub_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_sub_category(sub_category, @invalid_attrs)
      assert sub_category == Products.get_sub_category!(sub_category.id)
    end

    test "delete_sub_category/1 deletes the sub_category" do
      sub_category = sub_category_fixture()
      assert {:ok, %SubCategory{}} = Products.delete_sub_category(sub_category)
      assert_raise Ecto.NoResultsError, fn -> Products.get_sub_category!(sub_category.id) end
    end

    test "change_sub_category/1 returns a sub_category changeset" do
      sub_category = sub_category_fixture()
      assert %Ecto.Changeset{} = Products.change_sub_category(sub_category)
    end
  end

  describe "products" do
    alias LiveCommerce.Products.Product

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{name: nil, description: nil, deleted_at: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", description: "some description", deleted_at: ~U[2024-10-30 04:43:00Z]}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.deleted_at == ~U[2024-10-30 04:43:00Z]
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", deleted_at: ~U[2024-10-31 04:43:00Z]}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.deleted_at == ~U[2024-10-31 04:43:00Z]
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end

  describe "products_skus" do
    alias LiveCommerce.Products.ProductSKU

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{sku: nil, price: nil, quantity: nil, published: nil, deleted_at: nil}

    test "list_products_skus/0 returns all products_skus" do
      product_sku = product_sku_fixture()
      assert Products.list_products_skus() == [product_sku]
    end

    test "get_product_sku!/1 returns the product_sku with given id" do
      product_sku = product_sku_fixture()
      assert Products.get_product_sku!(product_sku.id) == product_sku
    end

    test "create_product_sku/1 with valid data creates a product_sku" do
      valid_attrs = %{sku: "some sku", price: "some price", quantity: 42, published: true, deleted_at: ~U[2024-10-30 04:43:00Z]}

      assert {:ok, %ProductSKU{} = product_sku} = Products.create_product_sku(valid_attrs)
      assert product_sku.sku == "some sku"
      assert product_sku.price == "some price"
      assert product_sku.quantity == 42
      assert product_sku.published == true
      assert product_sku.deleted_at == ~U[2024-10-30 04:43:00Z]
    end

    test "create_product_sku/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product_sku(@invalid_attrs)
    end

    test "update_product_sku/2 with valid data updates the product_sku" do
      product_sku = product_sku_fixture()
      update_attrs = %{sku: "some updated sku", price: "some updated price", quantity: 43, published: false, deleted_at: ~U[2024-10-31 04:43:00Z]}

      assert {:ok, %ProductSKU{} = product_sku} = Products.update_product_sku(product_sku, update_attrs)
      assert product_sku.sku == "some updated sku"
      assert product_sku.price == "some updated price"
      assert product_sku.quantity == 43
      assert product_sku.published == false
      assert product_sku.deleted_at == ~U[2024-10-31 04:43:00Z]
    end

    test "update_product_sku/2 with invalid data returns error changeset" do
      product_sku = product_sku_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product_sku(product_sku, @invalid_attrs)
      assert product_sku == Products.get_product_sku!(product_sku.id)
    end

    test "delete_product_sku/1 deletes the product_sku" do
      product_sku = product_sku_fixture()
      assert {:ok, %ProductSKU{}} = Products.delete_product_sku(product_sku)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product_sku!(product_sku.id) end
    end

    test "change_product_sku/1 returns a product_sku changeset" do
      product_sku = product_sku_fixture()
      assert %Ecto.Changeset{} = Products.change_product_sku(product_sku)
    end
  end

  describe "product_cover_images" do
    alias LiveCommerce.Products.ProductCoverImage

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{cover: nil, deleted_at: nil}

    test "list_product_cover_images/0 returns all product_cover_images" do
      product_cover_image = product_cover_image_fixture()
      assert Products.list_product_cover_images() == [product_cover_image]
    end

    test "get_product_cover_image!/1 returns the product_cover_image with given id" do
      product_cover_image = product_cover_image_fixture()
      assert Products.get_product_cover_image!(product_cover_image.id) == product_cover_image
    end

    test "create_product_cover_image/1 with valid data creates a product_cover_image" do
      valid_attrs = %{cover: "some cover", deleted_at: ~U[2024-10-30 04:44:00Z]}

      assert {:ok, %ProductCoverImage{} = product_cover_image} = Products.create_product_cover_image(valid_attrs)
      assert product_cover_image.cover == "some cover"
      assert product_cover_image.deleted_at == ~U[2024-10-30 04:44:00Z]
    end

    test "create_product_cover_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product_cover_image(@invalid_attrs)
    end

    test "update_product_cover_image/2 with valid data updates the product_cover_image" do
      product_cover_image = product_cover_image_fixture()
      update_attrs = %{cover: "some updated cover", deleted_at: ~U[2024-10-31 04:44:00Z]}

      assert {:ok, %ProductCoverImage{} = product_cover_image} = Products.update_product_cover_image(product_cover_image, update_attrs)
      assert product_cover_image.cover == "some updated cover"
      assert product_cover_image.deleted_at == ~U[2024-10-31 04:44:00Z]
    end

    test "update_product_cover_image/2 with invalid data returns error changeset" do
      product_cover_image = product_cover_image_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product_cover_image(product_cover_image, @invalid_attrs)
      assert product_cover_image == Products.get_product_cover_image!(product_cover_image.id)
    end

    test "delete_product_cover_image/1 deletes the product_cover_image" do
      product_cover_image = product_cover_image_fixture()
      assert {:ok, %ProductCoverImage{}} = Products.delete_product_cover_image(product_cover_image)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product_cover_image!(product_cover_image.id) end
    end

    test "change_product_cover_image/1 returns a product_cover_image changeset" do
      product_cover_image = product_cover_image_fixture()
      assert %Ecto.Changeset{} = Products.change_product_cover_image(product_cover_image)
    end
  end

  describe "product_perks" do
    alias LiveCommerce.Products.ProductPerk

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{perk: nil, deleted_at: nil}

    test "list_product_perks/0 returns all product_perks" do
      product_perk = product_perk_fixture()
      assert Products.list_product_perks() == [product_perk]
    end

    test "get_product_perk!/1 returns the product_perk with given id" do
      product_perk = product_perk_fixture()
      assert Products.get_product_perk!(product_perk.id) == product_perk
    end

    test "create_product_perk/1 with valid data creates a product_perk" do
      valid_attrs = %{perk: "some perk", deleted_at: ~U[2024-10-30 04:45:00Z]}

      assert {:ok, %ProductPerk{} = product_perk} = Products.create_product_perk(valid_attrs)
      assert product_perk.perk == "some perk"
      assert product_perk.deleted_at == ~U[2024-10-30 04:45:00Z]
    end

    test "create_product_perk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product_perk(@invalid_attrs)
    end

    test "update_product_perk/2 with valid data updates the product_perk" do
      product_perk = product_perk_fixture()
      update_attrs = %{perk: "some updated perk", deleted_at: ~U[2024-10-31 04:45:00Z]}

      assert {:ok, %ProductPerk{} = product_perk} = Products.update_product_perk(product_perk, update_attrs)
      assert product_perk.perk == "some updated perk"
      assert product_perk.deleted_at == ~U[2024-10-31 04:45:00Z]
    end

    test "update_product_perk/2 with invalid data returns error changeset" do
      product_perk = product_perk_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product_perk(product_perk, @invalid_attrs)
      assert product_perk == Products.get_product_perk!(product_perk.id)
    end

    test "delete_product_perk/1 deletes the product_perk" do
      product_perk = product_perk_fixture()
      assert {:ok, %ProductPerk{}} = Products.delete_product_perk(product_perk)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product_perk!(product_perk.id) end
    end

    test "change_product_perk/1 returns a product_perk changeset" do
      product_perk = product_perk_fixture()
      assert %Ecto.Changeset{} = Products.change_product_perk(product_perk)
    end
  end

  describe "product_attributes" do
    alias LiveCommerce.Products.ProductAttribute

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{attribute: nil, deleted_at: nil}

    test "list_product_attributes/0 returns all product_attributes" do
      product_attribute = product_attribute_fixture()
      assert Products.list_product_attributes() == [product_attribute]
    end

    test "get_product_attribute!/1 returns the product_attribute with given id" do
      product_attribute = product_attribute_fixture()
      assert Products.get_product_attribute!(product_attribute.id) == product_attribute
    end

    test "create_product_attribute/1 with valid data creates a product_attribute" do
      valid_attrs = %{attribute: %{}, deleted_at: ~U[2024-10-30 04:45:00Z]}

      assert {:ok, %ProductAttribute{} = product_attribute} = Products.create_product_attribute(valid_attrs)
      assert product_attribute.attribute == %{}
      assert product_attribute.deleted_at == ~U[2024-10-30 04:45:00Z]
    end

    test "create_product_attribute/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product_attribute(@invalid_attrs)
    end

    test "update_product_attribute/2 with valid data updates the product_attribute" do
      product_attribute = product_attribute_fixture()
      update_attrs = %{attribute: %{}, deleted_at: ~U[2024-10-31 04:45:00Z]}

      assert {:ok, %ProductAttribute{} = product_attribute} = Products.update_product_attribute(product_attribute, update_attrs)
      assert product_attribute.attribute == %{}
      assert product_attribute.deleted_at == ~U[2024-10-31 04:45:00Z]
    end

    test "update_product_attribute/2 with invalid data returns error changeset" do
      product_attribute = product_attribute_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product_attribute(product_attribute, @invalid_attrs)
      assert product_attribute == Products.get_product_attribute!(product_attribute.id)
    end

    test "delete_product_attribute/1 deletes the product_attribute" do
      product_attribute = product_attribute_fixture()
      assert {:ok, %ProductAttribute{}} = Products.delete_product_attribute(product_attribute)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product_attribute!(product_attribute.id) end
    end

    test "change_product_attribute/1 returns a product_attribute changeset" do
      product_attribute = product_attribute_fixture()
      assert %Ecto.Changeset{} = Products.change_product_attribute(product_attribute)
    end
  end

  describe "item_models" do
    alias LiveCommerce.Products.ItemModel

    import LiveCommerce.ProductsFixtures

    @invalid_attrs %{value: nil, deleted_at: nil}

    test "list_item_models/0 returns all item_models" do
      item_model = item_model_fixture()
      assert Products.list_item_models() == [item_model]
    end

    test "get_item_model!/1 returns the item_model with given id" do
      item_model = item_model_fixture()
      assert Products.get_item_model!(item_model.id) == item_model
    end

    test "create_item_model/1 with valid data creates a item_model" do
      valid_attrs = %{value: %{}, deleted_at: ~U[2024-10-30 04:46:00Z]}

      assert {:ok, %ItemModel{} = item_model} = Products.create_item_model(valid_attrs)
      assert item_model.value == %{}
      assert item_model.deleted_at == ~U[2024-10-30 04:46:00Z]
    end

    test "create_item_model/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_item_model(@invalid_attrs)
    end

    test "update_item_model/2 with valid data updates the item_model" do
      item_model = item_model_fixture()
      update_attrs = %{value: %{}, deleted_at: ~U[2024-10-31 04:46:00Z]}

      assert {:ok, %ItemModel{} = item_model} = Products.update_item_model(item_model, update_attrs)
      assert item_model.value == %{}
      assert item_model.deleted_at == ~U[2024-10-31 04:46:00Z]
    end

    test "update_item_model/2 with invalid data returns error changeset" do
      item_model = item_model_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_item_model(item_model, @invalid_attrs)
      assert item_model == Products.get_item_model!(item_model.id)
    end

    test "delete_item_model/1 deletes the item_model" do
      item_model = item_model_fixture()
      assert {:ok, %ItemModel{}} = Products.delete_item_model(item_model)
      assert_raise Ecto.NoResultsError, fn -> Products.get_item_model!(item_model.id) end
    end

    test "change_item_model/1 returns a item_model changeset" do
      item_model = item_model_fixture()
      assert %Ecto.Changeset{} = Products.change_item_model(item_model)
    end
  end
end
