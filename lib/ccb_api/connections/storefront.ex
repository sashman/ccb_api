defmodule CcbApi.Connections.Storefront do
  alias CcbApi.Items.Product
  use Memoize

  @callback name() :: String.t()
  @callback integration_schema() :: module()
  @callback scrape_storefront_products() :: {:ok, %{}}
  @callback to_product(%{}) :: %Product{}

  defmemo all do
    for {module, _} <- :code.all_loaded(),
        __MODULE__ in (module.module_info(:attributes)[:behaviour] || []) do
      module
    end
  end

  def exists?(storefront) when is_binary(storefront),
    do: storefront in (all() |> Enum.map(& &1.name))

  def exists?(_), do: false

  def to_schema(storefront_name) do
    {storefront, _} =
      all()
      |> Enum.map(fn s -> {s, s.name} end)
      |> Enum.find(fn {_, name} -> name == storefront_name end)

    storefront.integration_schema()
  end

  def schema_to_name(schema) do
    {storefront, _} =
      all()
      |> Enum.map(fn s -> {s, s.integration_schema} end)
      |> Enum.find(fn {_, integration_schema} -> integration_schema == schema end)

    storefront.name()
  end

  def all_products do
    all()
    |> Enum.map(fn storefront ->
      with {:ok, storefront_products_resp} <- storefront.scrape_storefront_products,
           %{data: data} <- storefront_products_resp do
        data
        |> Enum.map(fn product_record ->
          storefront.to_product(product_record)
        end)
      end
    end)
    |> List.flatten()
  end
end
