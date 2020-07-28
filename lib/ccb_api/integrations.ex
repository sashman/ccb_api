defmodule CcbApi.Integrations do
  @moduledoc """
  The Integrations context.
  """

  import Ecto.Query, warn: false
  alias CcbApi.Repo
  alias CcbApi.Tenant.Helper

  alias CcbApi.Connections.Storefront
  alias CcbApi.Integrations.ShopifyIntegration

  @doc """
  Returns the list of storefront_integrations.

  ## Examples

      iex> list_storefront_integrations()
      [%ShopifyIntegration{}, ...]

  """
  def list_storefront_integrations do
    Storefront.all()
    |> Enum.map(& &1.integration_schema)
    |> Enum.map(fn schema ->
      Repo.all(schema, prefix: Triplex.to_prefix(Helper.tenant()))
    end)
    |> List.flatten()
  end

  def create_storefront_integration(schema, attrs \\ %{}) when is_atom(schema) do
    struct(schema)
    |> schema.changeset(attrs)
    |> Repo.insert(prefix: Triplex.to_prefix(Helper.tenant()))
  end

  @doc """
  Returns the list of shopify_integrations.

  ## Examples

      iex> list_shopify_integrations()
      [%ShopifyIntegration{}, ...]

  """
  def list_shopify_integrations do
    Repo.all(ShopifyIntegration, prefix: Triplex.to_prefix(Helper.tenant()))
  end

  @doc """
  Gets a single shopify_integration.

  Raises `Ecto.NoResultsError` if the Shopify integration does not exist.

  ## Examples

      iex> get_shopify_integration!(123)
      %ShopifyIntegration{}

      iex> get_shopify_integration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shopify_integration!(id),
    do: Repo.get!(ShopifyIntegration, id, prefix: Triplex.to_prefix(Helper.tenant()))

  @doc """
  Creates a shopify_integration.

  ## Examples

      iex> create_shopify_integration(%{field: value})
      {:ok, %ShopifyIntegration{}}

      iex> create_shopify_integration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shopify_integration(attrs \\ %{}) do
    %ShopifyIntegration{}
    |> ShopifyIntegration.changeset(attrs)
    |> Repo.insert(prefix: Triplex.to_prefix(Helper.tenant()))
  end

  @doc """
  Updates a shopify_integration.

  ## Examples

      iex> update_shopify_integration(shopify_integration, %{field: new_value})
      {:ok, %ShopifyIntegration{}}

      iex> update_shopify_integration(shopify_integration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shopify_integration(%ShopifyIntegration{} = shopify_integration, attrs) do
    shopify_integration
    |> ShopifyIntegration.changeset(attrs)
    |> Repo.update(prefix: Triplex.to_prefix(Helper.tenant()))
  end

  @doc """
  Deletes a shopify_integration.

  ## Examples

      iex> delete_shopify_integration(shopify_integration)
      {:ok, %ShopifyIntegration{}}

      iex> delete_shopify_integration(shopify_integration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shopify_integration(%ShopifyIntegration{} = shopify_integration) do
    Repo.delete(shopify_integration, prefix: Triplex.to_prefix(Helper.tenant()))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shopify_integration changes.

  ## Examples

      iex> change_shopify_integration(shopify_integration)
      %Ecto.Changeset{data: %ShopifyIntegration{}}

  """
  def change_shopify_integration(%ShopifyIntegration{} = shopify_integration, attrs \\ %{}) do
    ShopifyIntegration.changeset(shopify_integration, attrs)
  end
end
