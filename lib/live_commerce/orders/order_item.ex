defmodule LiveCommerce.Orders.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :quantity, :deleted_at, :order_id, :product_id, :products_sku_id, :inserted_at, :updated_at]}
  schema "order_items" do
    field :quantity, :integer
    field :deleted_at, :utc_datetime
    field :order_id, :id
    field :product_id, :id
    field :products_sku_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:quantity, :deleted_at])
    |> validate_required([:quantity, :deleted_at])
  end
end
