defmodule CcbApiWeb.Router do
  use CcbApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CcbApiWeb do
    pipe_through :api

    resources "/customers", CustomerController, except: [:new, :edit]
    resources "/products", ProductController, except: [:new, :edit]
    resources "/items", ItemController, except: [:new, :edit]
    resources "/item_options", ItemOptionController, except: [:new, :edit]
    resources "/orders", OrderController, except: [:new, :edit]
    resources "/order_lines", OrderLineController, except: [:new, :edit]
    resources "/deliveries", DeliveryController, except: [:new, :edit]
    resources "/delivery_lines", DeliveryLineController, except: [:new, :edit]
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
end
