defmodule CcbApi.Repo.Migrations.CreateItemOptions do
  use Ecto.Migration

  def change do
    create table(:item_options, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :value, :string
      add :item_id, references(:items, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:item_options, [:item_id])
  end
end
