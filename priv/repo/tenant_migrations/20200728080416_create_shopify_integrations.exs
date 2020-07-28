defmodule CcbApi.Repo.Migrations.CreateShopifyIntegrations do
  use Ecto.Migration

  def change do
    create table(:shopify_integrations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :shop_name, :string
      add :api_key, :string
      add :password, :string

      timestamps()
    end

    create unique_index(:shopify_integrations, [:shop_name])
  end
end
