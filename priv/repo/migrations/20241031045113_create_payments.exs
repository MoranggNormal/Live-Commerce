defmodule LiveCommerce.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :amount, :integer
      add :provider, :string
      add :status, :string
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:payments, [:order_id])
  end
end
