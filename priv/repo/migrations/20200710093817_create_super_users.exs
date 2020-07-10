defmodule CcbApi.Repo.Migrations.CreateSuperUsers do
  use Ecto.Migration

  def change do
    create table(:super_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string

      timestamps()
    end

  end
end
