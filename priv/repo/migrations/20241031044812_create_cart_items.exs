defmodule LiveCommerce.Repo.Migrations.CreateCartItems do
  use Ecto.Migration

  def change do
    create table(:cart_items) do
      add :quantity, :integer
      add :deleted_at, :utc_datetime
      add :cart_id, references(:carts, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)
      add :products_sku_id, references(:products_skus, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:cart_items, [:cart_id])
    create index(:cart_items, [:product_id])
    create index(:cart_items, [:products_sku_id])
  end
end
