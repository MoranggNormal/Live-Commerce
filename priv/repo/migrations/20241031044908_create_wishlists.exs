defmodule LiveCommerce.Repo.Migrations.CreateWishlists do
  use Ecto.Migration

  def change do
    create table(:wishlists) do
      add :deleted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:wishlists, [:user_id])
    create index(:wishlists, [:product_id])
  end
end
