defmodule CcbApi.Integrations.ShopifyIntegration do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shopify_integrations" do
    field :api_key, :string
    field :name, :string
    field :password, CcbApi.Encrypted.Binary
    field :shop_name, :string

    timestamps()
  end

  @doc false
  def changeset(shopify_integration, attrs) do
    shopify_integration
    |> cast(attrs, [:name, :shop_name, :api_key, :password])
    |> validate_required([:name, :shop_name, :api_key, :password])
    |> unique_constraint(:shop_name)
  end
end
