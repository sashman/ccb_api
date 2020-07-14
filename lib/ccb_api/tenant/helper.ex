defmodule CcbApi.Tenant.Helper do
  def tenant, do: Process.get(:current_tenant)
end
