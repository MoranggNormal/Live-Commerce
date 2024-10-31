defmodule LiveCommerce.Repo.Migrations.CreateProductAttributes do
  use Ecto.Migration

  def change do
    create table(:product_attributes) do
      add :attribute, :map
      add :deleted_at, :utc_datetime
      add :product_id, references(:products, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:product_attributes, [:product_id])
  end
end
