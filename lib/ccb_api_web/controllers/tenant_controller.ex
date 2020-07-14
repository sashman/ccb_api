defmodule CcbApiWeb.TenantController do
  use CcbApiWeb, :controller

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    tenants = Triplex.all()

    conn
    |> json(%{tenants: tenants})
  end

  def create(conn, %{"tenant" => %{"name" => tenant_name}}) when is_binary(tenant_name) do
    with {:ok, tenant_name} <- Triplex.create(tenant_name) do
      conn
      |> put_status(:created)
      |> json(%{name: tenant_name})
    else
      {:error, "ERROR 42P06 (duplicate_schema)" <> _} ->
        {:error, :tenant_exists}
    end
  end

  def show(conn, %{"id" => tenant_name}) do
    with true <- Triplex.exists?(tenant_name) do
      conn
      |> json(%{tenant: tenant_name})
    else
      false ->
        conn
        |> send_resp(:not_found, "")
    end
  end

  def delete(conn, %{"id" => tenant_name}) do
    with true <- Triplex.exists?(tenant_name),
         {:ok, _} <- Triplex.drop(tenant_name) do
      send_resp(conn, :no_content, "")
    else
      _ -> send_resp(conn, :not_found, "")
    end
  end
end
