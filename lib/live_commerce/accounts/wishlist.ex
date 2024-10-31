defmodule LiveCommerce.Accounts.Wishlist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wishlists" do
    field :deleted_at, :utc_datetime
    field :user_id, :id
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(wishlist, attrs) do
    wishlist
    |> cast(attrs, [:deleted_at])
    |> validate_required([:deleted_at])
  end
end
