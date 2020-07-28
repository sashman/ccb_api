defmodule CcbApiWeb.StorefrontIntegrationController do
  use CcbApiWeb, :controller

  alias CcbApi.Integrations
  alias CcbApi.Integrations.ShopifyIntegration
  alias CcbApi.Connections.Storefront

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    storefront_integrations = Integrations.list_storefront_integrations()
    render(conn, "index.json", storefront_integrations: storefront_integrations)
  end

  def create(conn, %{
        "storefront_integration" => storefront_integration_params,
        "storefront" => storefront
      }) do
    with true <- Storefront.exists?(storefront),
         {:ok, %{} = storefront_integration} <-
           Integrations.create_storefront_integration(
             Storefront.to_schema(storefront),
             storefront_integration_params
           ) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.storefront_integration_path(conn, :show, storefront_integration)
      )
      |> render("show.json", storefront_integration: storefront_integration)
    else
      false ->
        conn
        |> send_resp(:not_found, "Storefront integration not found")

      error ->
        error
    end
  end

  def show(conn, %{"id" => id}) do
    shopify_integration = Integrations.get_shopify_integration!(id)
    render(conn, "show.json", shopify_integration: shopify_integration)
  end

  def update(conn, %{"id" => id, "shopify_integration" => shopify_integration_params}) do
    shopify_integration = Integrations.get_shopify_integration!(id)

    with {:ok, %ShopifyIntegration{} = shopify_integration} <-
           Integrations.update_shopify_integration(
             shopify_integration,
             shopify_integration_params
           ) do
      render(conn, "show.json", shopify_integration: shopify_integration)
    end
  end

  def delete(conn, %{"id" => id}) do
    shopify_integration = Integrations.get_shopify_integration!(id)

    with {:ok, %ShopifyIntegration{}} <-
           Integrations.delete_shopify_integration(shopify_integration) do
      send_resp(conn, :no_content, "")
    end
  end
end
