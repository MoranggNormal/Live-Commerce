defmodule LiveCommerce.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :deleted_at, :utc_datetime
    field :branch_id, :id
    field :category_id, :id
    field :classification_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :deleted_at])
    |> validate_required([:name, :description, :deleted_at])
  end
end
