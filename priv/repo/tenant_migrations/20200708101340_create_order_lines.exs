defmodule CcbApi.Repo.Migrations.CreateOrderLines do
  use Ecto.Migration

  def change do
    create table(:order_lines, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :item_id, references(:items, on_delete: :nothing, type: :binary_id)
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:order_lines, [:item_id])
    create index(:order_lines, [:order_id])
  end
end
