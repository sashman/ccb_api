defmodule CcbApi.Inbound.DeliveryLine do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "delivery_lines" do
    field :quantity, :integer
    field :product_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(delivery_line, attrs) do
    delivery_line
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end
