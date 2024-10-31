defmodule LiveCommerce.Products.ProductAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_attributes" do
    field :attribute, :map
    field :deleted_at, :utc_datetime
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_attribute, attrs) do
    product_attribute
    |> cast(attrs, [:attribute, :deleted_at])
    |> validate_required([:deleted_at])
  end
end
