defmodule LiveCommerce.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :description, :string
      add :deleted_at, :utc_datetime
      add :branch_id, references(:branches, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:categories, [:branch_id])
  end
end
