defmodule LiveCommerce.Branches.Branch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "branches" do
    field :name, :string
    field :subdomain, :string
    field :parent_branch_id, :integer
    field :deleted_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(branch, attrs) do
    branch
    |> cast(attrs, [:name, :subdomain, :parent_branch_id, :deleted_at])
    |> validate_required([:name, :subdomain, :parent_branch_id, :deleted_at])
  end
end
