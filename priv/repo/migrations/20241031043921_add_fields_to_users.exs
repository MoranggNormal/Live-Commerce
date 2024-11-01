defmodule LiveCommerce.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :branch_id, references(:branches)
      add :first_name, :string
      add :last_name, :string
      add :birth_of_date, :date
      add :phone_number, :string
      add :deleted_at, :utc_datetime
    end
  end
end
