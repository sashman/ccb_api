defmodule CcbApi.Repo.Migrations.CreateDeliverieLines do
  use Ecto.Migration

  def change do
    create table(:deliverie_lines, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:deliverie_lines, [:product_id])
  end
end
