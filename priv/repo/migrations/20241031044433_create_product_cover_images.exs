defmodule LiveCommerce.Repo.Migrations.CreateProductCoverImages do
  use Ecto.Migration

  def change do
    create table(:product_cover_images) do
      add :cover, :string
      add :deleted_at, :utc_datetime
      add :product_id, references(:products, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:product_cover_images, [:product_id])
  end
end
