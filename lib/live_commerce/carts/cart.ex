defmodule LiveCommerce.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    field :total, :integer
    field :deleted_at, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:total, :deleted_at])
    |> validate_required([:total, :deleted_at])
  end
end
