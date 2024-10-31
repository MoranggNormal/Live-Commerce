defmodule LiveCommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :deleted_at, :utc_datetime
      add :branch_id, references(:branches, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)
      add :classification_id, references(:classifications, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:products, [:branch_id])
    create index(:products, [:category_id])
    create index(:products, [:classification_id])
  end
end
