defmodule CcbApiWeb.TenantControllerTest do
  use CcbApiWeb.ConnCase

  alias CcbApi.Tenants
  alias CcbApi.Tenants.Tenant

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:tenant) do
    {:ok, tenant} = Tenants.create_tenant(@create_attrs)
    tenant
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tenants", %{conn: conn} do
      conn = get(conn, Routes.tenant_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tenant" do
    test "renders tenant when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tenant_path(conn, :create), tenant: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.tenant_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tenant_path(conn, :create), tenant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tenant" do
    setup [:create_tenant]

    test "renders tenant when data is valid", %{conn: conn, tenant: %Tenant{id: id} = tenant} do
      conn = put(conn, Routes.tenant_path(conn, :update, tenant), tenant: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.tenant_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tenant: tenant} do
      conn = put(conn, Routes.tenant_path(conn, :update, tenant), tenant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tenant" do
    setup [:create_tenant]

    test "deletes chosen tenant", %{conn: conn, tenant: tenant} do
      conn = delete(conn, Routes.tenant_path(conn, :delete, tenant))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.tenant_path(conn, :show, tenant))
      end
    end
  end

  defp create_tenant(_) do
    tenant = fixture(:tenant)
    %{tenant: tenant}
  end
end
