defmodule CcbApi.Outbound.OrderLine do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_lines" do
    field :quantity, :integer
    field :item_id, :binary_id
    field :order_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(order_line, attrs) do
    order_line
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end
