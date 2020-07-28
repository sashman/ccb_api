defmodule CcbApi.IntegrationsTest do
  use CcbApi.DataCase

  alias CcbApi.Integrations

  describe "shopify_integrations" do
    alias CcbApi.Integrations.ShopifyIntegration

    @valid_attrs %{api_key: "some api_key", name: "some name", password: "some password", shop_name: "some shop_name"}
    @update_attrs %{api_key: "some updated api_key", name: "some updated name", password: "some updated password", shop_name: "some updated shop_name"}
    @invalid_attrs %{api_key: nil, name: nil, password: nil, shop_name: nil}

    def shopify_integration_fixture(attrs \\ %{}) do
      {:ok, shopify_integration} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Integrations.create_shopify_integration()

      shopify_integration
    end

    test "list_shopify_integrations/0 returns all shopify_integrations" do
      shopify_integration = shopify_integration_fixture()
      assert Integrations.list_shopify_integrations() == [shopify_integration]
    end

    test "get_shopify_integration!/1 returns the shopify_integration with given id" do
      shopify_integration = shopify_integration_fixture()
      assert Integrations.get_shopify_integration!(shopify_integration.id) == shopify_integration
    end

    test "create_shopify_integration/1 with valid data creates a shopify_integration" do
      assert {:ok, %ShopifyIntegration{} = shopify_integration} = Integrations.create_shopify_integration(@valid_attrs)
      assert shopify_integration.api_key == "some api_key"
      assert shopify_integration.name == "some name"
      assert shopify_integration.password == "some password"
      assert shopify_integration.shop_name == "some shop_name"
    end

    test "create_shopify_integration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Integrations.create_shopify_integration(@invalid_attrs)
    end

    test "update_shopify_integration/2 with valid data updates the shopify_integration" do
      shopify_integration = shopify_integration_fixture()
      assert {:ok, %ShopifyIntegration{} = shopify_integration} = Integrations.update_shopify_integration(shopify_integration, @update_attrs)
      assert shopify_integration.api_key == "some updated api_key"
      assert shopify_integration.name == "some updated name"
      assert shopify_integration.password == "some updated password"
      assert shopify_integration.shop_name == "some updated shop_name"
    end

    test "update_shopify_integration/2 with invalid data returns error changeset" do
      shopify_integration = shopify_integration_fixture()
      assert {:error, %Ecto.Changeset{}} = Integrations.update_shopify_integration(shopify_integration, @invalid_attrs)
      assert shopify_integration == Integrations.get_shopify_integration!(shopify_integration.id)
    end

    test "delete_shopify_integration/1 deletes the shopify_integration" do
      shopify_integration = shopify_integration_fixture()
      assert {:ok, %ShopifyIntegration{}} = Integrations.delete_shopify_integration(shopify_integration)
      assert_raise Ecto.NoResultsError, fn -> Integrations.get_shopify_integration!(shopify_integration.id) end
    end

    test "change_shopify_integration/1 returns a shopify_integration changeset" do
      shopify_integration = shopify_integration_fixture()
      assert %Ecto.Changeset{} = Integrations.change_shopify_integration(shopify_integration)
    end
  end
end
