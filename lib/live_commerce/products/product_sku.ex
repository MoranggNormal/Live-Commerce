defmodule LiveCommerce.Products.ProductSKU do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products_skus" do
    field :sku, :string
    field :price, :string
    field :quantity, :integer
    field :published, :boolean, default: false
    field :deleted_at, :utc_datetime
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_sku, attrs) do
    product_sku
    |> cast(attrs, [:sku, :price, :quantity, :published, :deleted_at])
    |> validate_required([:sku, :price, :quantity, :published, :deleted_at])
  end
end
