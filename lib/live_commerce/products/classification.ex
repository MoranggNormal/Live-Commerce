defmodule LiveCommerce.Products.Classification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classifications" do
    field :name, :string
    field :deleted_at, :utc_datetime
    field :branch_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(classification, attrs) do
    classification
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name, :deleted_at])
  end
end
