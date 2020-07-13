defmodule CcbApiWeb.Tenant.Helper do
  import Plug.Conn

  def ensure_loaded_failure(conn = %Plug.Conn{assigns: %{current_tenant: current_tenant}}, _)
      when not is_nil(current_tenant),
      do: conn

  def ensure_loaded_failure(conn, _) do
    conn
    |> put_status(:unauthorized)
    |> CcbApiWeb.FallbackController.call({:error, :unauthorized})
  end
end
