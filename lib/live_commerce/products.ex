defmodule LiveCommerce.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias LiveCommerce.Repo

  alias LiveCommerce.Products.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias LiveCommerce.Products.Classification

  @doc """
  Returns the list of classifications.

  ## Examples

      iex> list_classifications()
      [%Classification{}, ...]

  """
  def list_classifications do
    Repo.all(Classification)
  end

  @doc """
  Gets a single classification.

  Raises `Ecto.NoResultsError` if the Classification does not exist.

  ## Examples

      iex> get_classification!(123)
      %Classification{}

      iex> get_classification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_classification!(id), do: Repo.get!(Classification, id)

  @doc """
  Creates a classification.

  ## Examples

      iex> create_classification(%{field: value})
      {:ok, %Classification{}}

      iex> create_classification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_classification(attrs \\ %{}) do
    %Classification{}
    |> Classification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a classification.

  ## Examples

      iex> update_classification(classification, %{field: new_value})
      {:ok, %Classification{}}

      iex> update_classification(classification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_classification(%Classification{} = classification, attrs) do
    classification
    |> Classification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a classification.

  ## Examples

      iex> delete_classification(classification)
      {:ok, %Classification{}}

      iex> delete_classification(classification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_classification(%Classification{} = classification) do
    Repo.delete(classification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking classification changes.

  ## Examples

      iex> change_classification(classification)
      %Ecto.Changeset{data: %Classification{}}

  """
  def change_classification(%Classification{} = classification, attrs \\ %{}) do
    Classification.changeset(classification, attrs)
  end

  alias LiveCommerce.Products.SubCategory

  @doc """
  Returns the list of sub_categories.

  ## Examples

      iex> list_sub_categories()
      [%SubCategory{}, ...]

  """
  def list_sub_categories do
    Repo.all(SubCategory)
  end

  @doc """
  Gets a single sub_category.

  Raises `Ecto.NoResultsError` if the Sub category does not exist.

  ## Examples

      iex> get_sub_category!(123)
      %SubCategory{}

      iex> get_sub_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sub_category!(id), do: Repo.get!(SubCategory, id)

  @doc """
  Creates a sub_category.

  ## Examples

      iex> create_sub_category(%{field: value})
      {:ok, %SubCategory{}}

      iex> create_sub_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_category(attrs \\ %{}) do
    %SubCategory{}
    |> SubCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sub_category.

  ## Examples

      iex> update_sub_category(sub_category, %{field: new_value})
      {:ok, %SubCategory{}}

      iex> update_sub_category(sub_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sub_category(%SubCategory{} = sub_category, attrs) do
    sub_category
    |> SubCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sub_category.

  ## Examples

      iex> delete_sub_category(sub_category)
      {:ok, %SubCategory{}}

      iex> delete_sub_category(sub_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sub_category(%SubCategory{} = sub_category) do
    Repo.delete(sub_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sub_category changes.

  ## Examples

      iex> change_sub_category(sub_category)
      %Ecto.Changeset{data: %SubCategory{}}

  """
  def change_sub_category(%SubCategory{} = sub_category, attrs \\ %{}) do
    SubCategory.changeset(sub_category, attrs)
  end

  alias LiveCommerce.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  def count_products_for_branch(branch_id) do
    from(p in Product,
      where: p.branch_id == ^branch_id,
      select: count(p.id)
    )
    |> Repo.one()
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias LiveCommerce.Products.ProductSKU

  @doc """
  Returns the list of products_skus.

  ## Examples

      iex> list_products_skus()
      [%ProductSKU{}, ...]

  """
  def list_products_skus do
    Repo.all(ProductSKU)
  end

  @doc """
  Gets a single product_sku.

  Raises `Ecto.NoResultsError` if the Product sku does not exist.

  ## Examples

      iex> get_product_sku!(123)
      %ProductSKU{}

      iex> get_product_sku!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_sku!(id), do: Repo.get!(ProductSKU, id)

  @doc """
  Creates a product_sku.

  ## Examples

      iex> create_product_sku(%{field: value})
      {:ok, %ProductSKU{}}

      iex> create_product_sku(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_sku(attrs \\ %{}) do
    %ProductSKU{}
    |> ProductSKU.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_sku.

  ## Examples

      iex> update_product_sku(product_sku, %{field: new_value})
      {:ok, %ProductSKU{}}

      iex> update_product_sku(product_sku, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_sku(%ProductSKU{} = product_sku, attrs) do
    product_sku
    |> ProductSKU.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_sku.

  ## Examples

      iex> delete_product_sku(product_sku)
      {:ok, %ProductSKU{}}

      iex> delete_product_sku(product_sku)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_sku(%ProductSKU{} = product_sku) do
    Repo.delete(product_sku)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_sku changes.

  ## Examples

      iex> change_product_sku(product_sku)
      %Ecto.Changeset{data: %ProductSKU{}}

  """
  def change_product_sku(%ProductSKU{} = product_sku, attrs \\ %{}) do
    ProductSKU.changeset(product_sku, attrs)
  end

  alias LiveCommerce.Products.ProductCoverImage

  @doc """
  Returns the list of product_cover_images.

  ## Examples

      iex> list_product_cover_images()
      [%ProductCoverImage{}, ...]

  """
  def list_product_cover_images do
    Repo.all(ProductCoverImage)
  end

  @doc """
  Gets a single product_cover_image.

  Raises `Ecto.NoResultsError` if the Product cover image does not exist.

  ## Examples

      iex> get_product_cover_image!(123)
      %ProductCoverImage{}

      iex> get_product_cover_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_cover_image!(id), do: Repo.get!(ProductCoverImage, id)

  @doc """
  Creates a product_cover_image.

  ## Examples

      iex> create_product_cover_image(%{field: value})
      {:ok, %ProductCoverImage{}}

      iex> create_product_cover_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_cover_image(attrs \\ %{}) do
    %ProductCoverImage{}
    |> ProductCoverImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_cover_image.

  ## Examples

      iex> update_product_cover_image(product_cover_image, %{field: new_value})
      {:ok, %ProductCoverImage{}}

      iex> update_product_cover_image(product_cover_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_cover_image(%ProductCoverImage{} = product_cover_image, attrs) do
    product_cover_image
    |> ProductCoverImage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_cover_image.

  ## Examples

      iex> delete_product_cover_image(product_cover_image)
      {:ok, %ProductCoverImage{}}

      iex> delete_product_cover_image(product_cover_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_cover_image(%ProductCoverImage{} = product_cover_image) do
    Repo.delete(product_cover_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_cover_image changes.

  ## Examples

      iex> change_product_cover_image(product_cover_image)
      %Ecto.Changeset{data: %ProductCoverImage{}}

  """
  def change_product_cover_image(%ProductCoverImage{} = product_cover_image, attrs \\ %{}) do
    ProductCoverImage.changeset(product_cover_image, attrs)
  end

  alias LiveCommerce.Products.ProductPerk

  @doc """
  Returns the list of product_perks.

  ## Examples

      iex> list_product_perks()
      [%ProductPerk{}, ...]

  """
  def list_product_perks do
    Repo.all(ProductPerk)
  end

  @doc """
  Gets a single product_perk.

  Raises `Ecto.NoResultsError` if the Product perk does not exist.

  ## Examples

      iex> get_product_perk!(123)
      %ProductPerk{}

      iex> get_product_perk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_perk!(id), do: Repo.get!(ProductPerk, id)

  @doc """
  Creates a product_perk.

  ## Examples

      iex> create_product_perk(%{field: value})
      {:ok, %ProductPerk{}}

      iex> create_product_perk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_perk(attrs \\ %{}) do
    %ProductPerk{}
    |> ProductPerk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_perk.

  ## Examples

      iex> update_product_perk(product_perk, %{field: new_value})
      {:ok, %ProductPerk{}}

      iex> update_product_perk(product_perk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_perk(%ProductPerk{} = product_perk, attrs) do
    product_perk
    |> ProductPerk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_perk.

  ## Examples

      iex> delete_product_perk(product_perk)
      {:ok, %ProductPerk{}}

      iex> delete_product_perk(product_perk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_perk(%ProductPerk{} = product_perk) do
    Repo.delete(product_perk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_perk changes.

  ## Examples

      iex> change_product_perk(product_perk)
      %Ecto.Changeset{data: %ProductPerk{}}

  """
  def change_product_perk(%ProductPerk{} = product_perk, attrs \\ %{}) do
    ProductPerk.changeset(product_perk, attrs)
  end

  alias LiveCommerce.Products.ProductAttribute

  @doc """
  Returns the list of product_attributes.

  ## Examples

      iex> list_product_attributes()
      [%ProductAttribute{}, ...]

  """
  def list_product_attributes do
    Repo.all(ProductAttribute)
  end

  @doc """
  Gets a single product_attribute.

  Raises `Ecto.NoResultsError` if the Product attribute does not exist.

  ## Examples

      iex> get_product_attribute!(123)
      %ProductAttribute{}

      iex> get_product_attribute!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_attribute!(id), do: Repo.get!(ProductAttribute, id)

  @doc """
  Creates a product_attribute.

  ## Examples

      iex> create_product_attribute(%{field: value})
      {:ok, %ProductAttribute{}}

      iex> create_product_attribute(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_attribute(attrs \\ %{}) do
    %ProductAttribute{}
    |> ProductAttribute.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_attribute.

  ## Examples

      iex> update_product_attribute(product_attribute, %{field: new_value})
      {:ok, %ProductAttribute{}}

      iex> update_product_attribute(product_attribute, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_attribute(%ProductAttribute{} = product_attribute, attrs) do
    product_attribute
    |> ProductAttribute.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_attribute.

  ## Examples

      iex> delete_product_attribute(product_attribute)
      {:ok, %ProductAttribute{}}

      iex> delete_product_attribute(product_attribute)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_attribute(%ProductAttribute{} = product_attribute) do
    Repo.delete(product_attribute)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_attribute changes.

  ## Examples

      iex> change_product_attribute(product_attribute)
      %Ecto.Changeset{data: %ProductAttribute{}}

  """
  def change_product_attribute(%ProductAttribute{} = product_attribute, attrs \\ %{}) do
    ProductAttribute.changeset(product_attribute, attrs)
  end

  alias LiveCommerce.Products.ItemModel

  @doc """
  Returns the list of item_models.

  ## Examples

      iex> list_item_models()
      [%ItemModel{}, ...]

  """
  def list_item_models do
    Repo.all(ItemModel)
  end

  @doc """
  Gets a single item_model.

  Raises `Ecto.NoResultsError` if the Item model does not exist.

  ## Examples

      iex> get_item_model!(123)
      %ItemModel{}

      iex> get_item_model!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item_model!(id), do: Repo.get!(ItemModel, id)

  @doc """
  Creates a item_model.

  ## Examples

      iex> create_item_model(%{field: value})
      {:ok, %ItemModel{}}

      iex> create_item_model(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item_model(attrs \\ %{}) do
    %ItemModel{}
    |> ItemModel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item_model.

  ## Examples

      iex> update_item_model(item_model, %{field: new_value})
      {:ok, %ItemModel{}}

      iex> update_item_model(item_model, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item_model(%ItemModel{} = item_model, attrs) do
    item_model
    |> ItemModel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item_model.

  ## Examples

      iex> delete_item_model(item_model)
      {:ok, %ItemModel{}}

      iex> delete_item_model(item_model)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item_model(%ItemModel{} = item_model) do
    Repo.delete(item_model)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item_model changes.

  ## Examples

      iex> change_item_model(item_model)
      %Ecto.Changeset{data: %ItemModel{}}

  """
  def change_item_model(%ItemModel{} = item_model, attrs \\ %{}) do
    ItemModel.changeset(item_model, attrs)
  end
end
