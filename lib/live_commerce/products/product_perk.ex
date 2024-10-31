defmodule LiveCommerce.Products.ProductPerk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_perks" do
    field :perk, :string
    field :deleted_at, :utc_datetime
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_perk, attrs) do
    product_perk
    |> cast(attrs, [:perk, :deleted_at])
    |> validate_required([:perk, :deleted_at])
  end
end
