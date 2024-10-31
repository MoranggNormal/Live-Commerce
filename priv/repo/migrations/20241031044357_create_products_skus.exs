defmodule LiveCommerce.Repo.Migrations.CreateProductsSkus do
  use Ecto.Migration

  def change do
    create table(:products_skus) do
      add :sku, :string
      add :price, :string
      add :quantity, :integer
      add :published, :boolean, default: false, null: false
      add :deleted_at, :utc_datetime
      add :product_id, references(:products, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:products_skus, [:product_id])
  end
end
