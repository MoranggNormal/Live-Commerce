defmodule LiveCommerce.Repo.Migrations.CreateClassifications do
  use Ecto.Migration

  def change do
    create table(:classifications) do
      add :name, :string
      add :deleted_at, :utc_datetime
      add :branch_id, references(:branches, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:classifications, [:branch_id])
  end
end
