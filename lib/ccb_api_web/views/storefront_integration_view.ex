defmodule CcbApiWeb.StorefrontIntegrationView do
  use CcbApiWeb, :view
  alias CcbApiWeb.StorefrontIntegrationView

  def render("index.json", %{storefront_integrations: storefront_integrations}) do
    %{data: render_many(storefront_integrations, StorefrontIntegrationView, "storefront_integration.json")}
  end

  def render("show.json", %{storefront_integration: storefront_integration}) do
    %{data: render_one(storefront_integration, StorefrontIntegrationView, "storefront_integration.json")}
  end

  def render("storefront_integration.json", %{storefront_integration: storefront_integration}) do
    %{id: storefront_integration.id,
      name: storefront_integration.name,
      shop_name: storefront_integration.shop_name,
      api_key: storefront_integration.api_key,
      password: storefront_integration.password}
  end
end
