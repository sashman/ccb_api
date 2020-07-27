defmodule CcbApi.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias CcbApi.Items.Product

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "items" do
    field :quantity, :integer
    field :sku, :string
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:sku, :quantity, :product_id])
    |> validate_required([:sku, :quantity, :product_id])
  end
end
