defmodule CcbApi.Items.ItemOption do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "item_options" do
    field :name, :string
    field :value, :string
    field :item_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(item_option, attrs) do
    item_option
    |> cast(attrs, [:name, :value])
    |> validate_required([:name, :value])
  end
end
