defmodule CcbApiWeb.ShopifyIntegrationControllerTest do
  use CcbApiWeb.ConnCase

  alias CcbApi.Integrations
  alias CcbApi.Integrations.ShopifyIntegration

  @create_attrs %{
    api_key: "some api_key",
    name: "some name",
    password: "some password",
    shop_name: "some shop_name"
  }
  @update_attrs %{
    api_key: "some updated api_key",
    name: "some updated name",
    password: "some updated password",
    shop_name: "some updated shop_name"
  }
  @invalid_attrs %{api_key: nil, name: nil, password: nil, shop_name: nil}

  def fixture(:shopify_integration) do
    {:ok, shopify_integration} = Integrations.create_shopify_integration(@create_attrs)
    shopify_integration
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all shopify_integrations", %{conn: conn} do
      conn = get(conn, Routes.shopify_integration_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create shopify_integration" do
    test "renders shopify_integration when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shopify_integration_path(conn, :create), shopify_integration: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.shopify_integration_path(conn, :show, id))

      assert %{
               "id" => id,
               "api_key" => "some api_key",
               "name" => "some name",
               "password" => "some password",
               "shop_name" => "some shop_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shopify_integration_path(conn, :create), shopify_integration: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update shopify_integration" do
    setup [:create_shopify_integration]

    test "renders shopify_integration when data is valid", %{conn: conn, shopify_integration: %ShopifyIntegration{id: id} = shopify_integration} do
      conn = put(conn, Routes.shopify_integration_path(conn, :update, shopify_integration), shopify_integration: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.shopify_integration_path(conn, :show, id))

      assert %{
               "id" => id,
               "api_key" => "some updated api_key",
               "name" => "some updated name",
               "password" => "some updated password",
               "shop_name" => "some updated shop_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, shopify_integration: shopify_integration} do
      conn = put(conn, Routes.shopify_integration_path(conn, :update, shopify_integration), shopify_integration: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete shopify_integration" do
    setup [:create_shopify_integration]

    test "deletes chosen shopify_integration", %{conn: conn, shopify_integration: shopify_integration} do
      conn = delete(conn, Routes.shopify_integration_path(conn, :delete, shopify_integration))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.shopify_integration_path(conn, :show, shopify_integration))
      end
    end
  end

  defp create_shopify_integration(_) do
    shopify_integration = fixture(:shopify_integration)
    %{shopify_integration: shopify_integration}
  end
end
