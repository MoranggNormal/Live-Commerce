defmodule LiveCommerce.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :status, :string
    field :total, :integer
    field :payment_id, :integer
    field :deleted_at, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:payment_id, :total, :status, :deleted_at])
    |> validate_required([:payment_id, :total, :status, :deleted_at])
  end
end
