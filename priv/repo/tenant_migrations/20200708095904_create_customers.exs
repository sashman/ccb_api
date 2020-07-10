defmodule CcbApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end
  end
end
