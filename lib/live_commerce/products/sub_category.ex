defmodule LiveCommerce.Products.SubCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sub_categories" do
    field :name, :string
    field :description, :string
    field :deleted_at, :utc_datetime
    field :parent_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sub_category, attrs) do
    sub_category
    |> cast(attrs, [:name, :description, :deleted_at])
    |> validate_required([:name, :description, :deleted_at])
  end
end
