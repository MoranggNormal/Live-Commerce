defmodule LiveCommerce.Products.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :description, :string
    field :deleted_at, :utc_datetime
    field :branch_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description, :created_at, :updated_at, :deleted_at])
    |> validate_required([:name, :description, :created_at, :updated_at, :deleted_at])
  end
end
