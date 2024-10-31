defmodule LiveCommerce.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :payment_id, :integer
      add :total, :integer
      add :status, :string
      add :deleted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:user_id])
  end
end
