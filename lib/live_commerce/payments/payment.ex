defmodule LiveCommerce.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :status, :string
    field :provider, :string
    field :amount, :integer
    field :order_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :provider, :status])
    |> validate_required([:amount, :provider, :status])
  end
end
