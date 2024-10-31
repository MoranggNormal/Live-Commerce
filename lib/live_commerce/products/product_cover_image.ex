defmodule LiveCommerce.Products.ProductCoverImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_cover_images" do
    field :cover, :string
    field :deleted_at, :utc_datetime
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_cover_image, attrs) do
    product_cover_image
    |> cast(attrs, [:cover, :deleted_at])
    |> validate_required([:cover, :deleted_at])
  end
end
