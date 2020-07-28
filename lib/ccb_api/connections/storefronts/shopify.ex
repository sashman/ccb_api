defmodule CcbApi.Connections.Storefronts.Shopify do
  alias CcbApi.Connections.Storefront
  @behaviour Storefront

  @shop_name "sash-test-store"
  @api_key "c44504e0570ef98f24e993fbac9092ae"
  @password "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"

  @impl Storefront
  def name(), do: __MODULE__ |> to_string() |> String.split(".") |> List.last()

  @impl Storefront
  def integration_schema(), do: CcbApi.Integrations.ShopifyIntegration

  @impl Storefront
  def scrape_storefront_products(
        shop_name \\ @shop_name,
        api_key \\ @api_key,
        password \\ @password
      ) do
    shop_name
    |> Shopify.session(api_key, password)
    |> Shopify.Product.all()
  end

  @impl Storefront
  def to_product(%Shopify.Product{
        body_html: description,
        title: title
      }),
      do: %CcbApi.Items.Product{
        title: title,
        description: description
      }
end
