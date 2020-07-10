defmodule CcbApi.Inbound do
  @moduledoc """
  The Inbound context.
  """

  import Ecto.Query, warn: false
  alias CcbApi.Repo

  alias CcbApi.Inbound.Delivery

  @doc """
  Returns the list of deliveries.

  ## Examples

      iex> list_deliveries()
      [%Delivery{}, ...]

  """
  def list_deliveries do
    Repo.all(Delivery)
  end

  @doc """
  Gets a single delivery.

  Raises `Ecto.NoResultsError` if the Delivery does not exist.

  ## Examples

      iex> get_delivery!(123)
      %Delivery{}

      iex> get_delivery!(456)
      ** (Ecto.NoResultsError)

  """
  def get_delivery!(id), do: Repo.get!(Delivery, id)

  @doc """
  Creates a delivery.

  ## Examples

      iex> create_delivery(%{field: value})
      {:ok, %Delivery{}}

      iex> create_delivery(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_delivery(attrs \\ %{}) do
    %Delivery{}
    |> Delivery.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a delivery.

  ## Examples

      iex> update_delivery(delivery, %{field: new_value})
      {:ok, %Delivery{}}

      iex> update_delivery(delivery, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_delivery(%Delivery{} = delivery, attrs) do
    delivery
    |> Delivery.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a delivery.

  ## Examples

      iex> delete_delivery(delivery)
      {:ok, %Delivery{}}

      iex> delete_delivery(delivery)
      {:error, %Ecto.Changeset{}}

  """
  def delete_delivery(%Delivery{} = delivery) do
    Repo.delete(delivery)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking delivery changes.

  ## Examples

      iex> change_delivery(delivery)
      %Ecto.Changeset{data: %Delivery{}}

  """
  def change_delivery(%Delivery{} = delivery, attrs \\ %{}) do
    Delivery.changeset(delivery, attrs)
  end

  alias CcbApi.Inbound.DeliveryLine

  @doc """
  Returns the list of delivery_lines.

  ## Examples

      iex> list_delivery_lines()
      [%DeliveryLine{}, ...]

  """
  def list_delivery_lines do
    Repo.all(DeliveryLine)
  end

  @doc """
  Gets a single delivery_line.

  Raises `Ecto.NoResultsError` if the Delivery line does not exist.

  ## Examples

      iex> get_delivery_line!(123)
      %DeliveryLine{}

      iex> get_delivery_line!(456)
      ** (Ecto.NoResultsError)

  """
  def get_delivery_line!(id), do: Repo.get!(DeliveryLine, id)

  @doc """
  Creates a delivery_line.

  ## Examples

      iex> create_delivery_line(%{field: value})
      {:ok, %DeliveryLine{}}

      iex> create_delivery_line(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_delivery_line(attrs \\ %{}) do
    %DeliveryLine{}
    |> DeliveryLine.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a delivery_line.

  ## Examples

      iex> update_delivery_line(delivery_line, %{field: new_value})
      {:ok, %DeliveryLine{}}

      iex> update_delivery_line(delivery_line, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_delivery_line(%DeliveryLine{} = delivery_line, attrs) do
    delivery_line
    |> DeliveryLine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a delivery_line.

  ## Examples

      iex> delete_delivery_line(delivery_line)
      {:ok, %DeliveryLine{}}

      iex> delete_delivery_line(delivery_line)
      {:error, %Ecto.Changeset{}}

  """
  def delete_delivery_line(%DeliveryLine{} = delivery_line) do
    Repo.delete(delivery_line)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking delivery_line changes.

  ## Examples

      iex> change_delivery_line(delivery_line)
      %Ecto.Changeset{data: %DeliveryLine{}}

  """
  def change_delivery_line(%DeliveryLine{} = delivery_line, attrs \\ %{}) do
    DeliveryLine.changeset(delivery_line, attrs)
  end
end
