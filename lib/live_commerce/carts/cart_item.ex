defmodule LiveCommerce.Carts.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cart_items" do
    field :quantity, :integer
    field :deleted_at, :utc_datetime
    field :cart_id, :id
    field :product_id, :id
    field :products_sku_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, [:quantity, :deleted_at])
    |> validate_required([:quantity, :deleted_at])
  end
end
