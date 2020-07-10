defmodule CcbApiWeb.TenantView do
  use CcbApiWeb, :view
  alias CcbApiWeb.TenantView

  def render("index.json", %{tenants: tenants}) do
    %{data: render_many(tenants, TenantView, "tenant.json")}
  end

  def render("show.json", %{tenant: tenant}) do
    %{data: render_one(tenant, TenantView, "tenant.json")}
  end

  def render("tenant.json", name) do
    %{name: name}
  end
end
