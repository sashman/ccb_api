defmodule CcbApiWeb.Tenant.Store do
  def init([]), do: false

  def call(conn, _opts) do
    Process.put(:current_tenant, conn.assigns.current_tenant)

    conn
  end
end
