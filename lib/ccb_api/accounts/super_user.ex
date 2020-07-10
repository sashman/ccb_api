defmodule CcbApi.Accounts.SuperUser do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "super_users" do
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(super_user, attrs) do
    super_user
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
