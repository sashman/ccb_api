defmodule CcbApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias CcbApi.Repo

  alias CcbApi.Accounts.SuperUser

  @doc """
  Returns the list of super_users.

  ## Examples

      iex> list_super_users()
      [%SuperUser{}, ...]

  """
  def list_super_users do
    Repo.all(SuperUser)
  end

  @doc """
  Gets a single super_user.

  Raises `Ecto.NoResultsError` if the Super user does not exist.

  ## Examples

      iex> get_super_user!(123)
      %SuperUser{}

      iex> get_super_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_super_user!(id), do: Repo.get!(SuperUser, id)

  @doc """
  Creates a super_user.

  ## Examples

      iex> create_super_user(%{field: value})
      {:ok, %SuperUser{}}

      iex> create_super_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_super_user(attrs \\ %{}) do
    %SuperUser{}
    |> SuperUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a super_user.

  ## Examples

      iex> update_super_user(super_user, %{field: new_value})
      {:ok, %SuperUser{}}

      iex> update_super_user(super_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_super_user(%SuperUser{} = super_user, attrs) do
    super_user
    |> SuperUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a super_user.

  ## Examples

      iex> delete_super_user(super_user)
      {:ok, %SuperUser{}}

      iex> delete_super_user(super_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_super_user(%SuperUser{} = super_user) do
    Repo.delete(super_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking super_user changes.

  ## Examples

      iex> change_super_user(super_user)
      %Ecto.Changeset{data: %SuperUser{}}

  """
  def change_super_user(%SuperUser{} = super_user, attrs \\ %{}) do
    SuperUser.changeset(super_user, attrs)
  end
end
