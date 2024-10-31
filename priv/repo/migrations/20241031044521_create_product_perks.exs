defmodule LiveCommerce.Repo.Migrations.CreateProductPerks do
  use Ecto.Migration

  def change do
    create table(:product_perks) do
      add :perk, :string
      add :deleted_at, :utc_datetime
      add :product_id, references(:products, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:product_perks, [:product_id])
  end
end
