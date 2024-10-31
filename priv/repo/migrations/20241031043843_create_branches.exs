defmodule LiveCommerce.Repo.Migrations.CreateBranches do
  use Ecto.Migration

  def change do
    create table(:branches) do
      add :name, :string
      add :subdomain, :string
      add :parent_branch_id, :integer
      add :deleted_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
