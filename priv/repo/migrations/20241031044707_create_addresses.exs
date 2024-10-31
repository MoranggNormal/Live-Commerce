defmodule LiveCommerce.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :title, :string
      add :address_line_1, :string
      add :address_line_2, :string
      add :country, :string
      add :city, :string
      add :postal_code, :string
      add :landmark, :string
      add :phone_number, :string
      add :deleted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :branch_id, references(:branches, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:addresses, [:user_id])
    create index(:addresses, [:branch_id])
  end
end
