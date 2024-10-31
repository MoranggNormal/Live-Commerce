defmodule LiveCommerce.Products.ItemModel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_models" do
    field :value, :map
    field :deleted_at, :utc_datetime
    field :branch_id, :id
    field :classification_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item_model, attrs) do
    item_model
    |> cast(attrs, [:value, :deleted_at])
    |> validate_required([:deleted_at])
  end
end
