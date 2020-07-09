defmodule CcbApi.Outbound.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :channel_reference, :string
    field :external_id, :string
    field :shipping_status, :string
    field :customer_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:external_id, :channel_reference, :shipping_status])
    |> validate_required([:external_id, :channel_reference, :shipping_status])
  end
end
