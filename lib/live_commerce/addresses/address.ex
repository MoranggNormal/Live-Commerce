defmodule LiveCommerce.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :title, :string
    field :address_line_1, :string
    field :address_line_2, :string
    field :country, :string
    field :city, :string
    field :postal_code, :string
    field :landmark, :string
    field :phone_number, :string
    field :deleted_at, :utc_datetime
    field :user_id, :id
    field :branch_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:title, :address_line_1, :address_line_2, :country, :city, :postal_code, :landmark, :phone_number, :deleted_at])
    |> validate_required([:title, :address_line_1, :address_line_2, :country, :city, :postal_code, :landmark, :phone_number, :deleted_at])
  end
end
