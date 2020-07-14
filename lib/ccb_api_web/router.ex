defmodule CcbApiWeb.Router do
  use CcbApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Auth.Guardian.Pipeline
  end

  pipeline :tenant do
    plug Triplex.SubdomainPlug,
      endpoint: CcbApiWeb.Endpoint

    plug Triplex.EnsurePlug,
      failure_callback: &CcbApiWeb.Tenant.Helper.ensure_loaded_failure/2

    plug :store_tenant
  end

  scope "/api", CcbApiWeb do
    pipe_through :api

    resources "/tenants", TenantController, only: [:index, :create, :delete, :show]

    scope "/" do
      pipe_through :tenant

      resources "/customers", CustomerController, except: [:new, :edit]
      resources "/products", ProductController, except: [:new, :edit]
      resources "/items", ItemController, except: [:new, :edit]
      resources "/item_options", ItemOptionController, except: [:new, :edit]
      resources "/orders", OrderController, except: [:new, :edit]
      resources "/order_lines", OrderLineController, except: [:new, :edit]
      resources "/deliveries", DeliveryController, except: [:new, :edit]
      resources "/delivery_lines", DeliveryLineController, except: [:new, :edit]
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: CcbApiWeb.Telemetry
    end
  end

  defp store_tenant(conn, _params) do
    Process.put(:current_tenant, conn.assigns.current_tenant)

    conn
  end
end
