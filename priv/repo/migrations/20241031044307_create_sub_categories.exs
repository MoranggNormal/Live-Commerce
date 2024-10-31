defmodule LiveCommerce.Repo.Migrations.CreateSubCategories do
  use Ecto.Migration

  def change do
    create table(:sub_categories) do
      add :name, :string
      add :description, :string
      add :deleted_at, :utc_datetime
      add :parent_id, references(:categories, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:sub_categories, [:parent_id])
  end
end
