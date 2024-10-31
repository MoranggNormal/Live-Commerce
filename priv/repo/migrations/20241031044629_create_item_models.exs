defmodule LiveCommerce.Repo.Migrations.CreateItemModels do
  use Ecto.Migration

  def change do
    create table(:item_models) do
      add :value, :map
      add :deleted_at, :utc_datetime
      add :branch_id, references(:branches, on_delete: :nothing)
      add :classification_id, references(:classifications, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:item_models, [:branch_id])
    create index(:item_models, [:classification_id])
  end
end
