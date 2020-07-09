defmodule CcbApi.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :string
      add :channel_reference, :string
      add :shipping_status, :string
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:orders, [:customer_id])
  end
end
