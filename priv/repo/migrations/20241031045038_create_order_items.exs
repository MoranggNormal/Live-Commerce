defmodule LiveCommerce.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :quantity, :integer
      add :deleted_at, :utc_datetime
      add :order_id, references(:orders, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)
      add :products_sku_id, references(:products_skus, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:order_items, [:order_id])
    create index(:order_items, [:product_id])
    create index(:order_items, [:products_sku_id])
  end
end
