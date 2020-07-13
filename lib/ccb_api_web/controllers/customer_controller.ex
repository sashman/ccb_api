defmodule CcbApiWeb.CustomerController do
  use CcbApiWeb, :controller

  alias CcbApi.Customers
  alias CcbApi.Customers.Customer

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    customers = Customers.list_customers(conn.assigns)
    render(conn, "index.json", customers: customers)
  end

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Customers.create_customer(customer_params, conn.assigns) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.customer_path(conn, :show, customer))
      |> render("show.json", customer: customer)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id, conn.assigns)
    render(conn, "show.json", customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Customers.get_customer!(id, conn.assigns)

    with {:ok, %Customer{} = customer} <-
           Customers.update_customer(customer, customer_params, conn.assigns) do
      render(conn, "show.json", customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id, conn.assigns)

    with {:ok, %Customer{}} <- Customers.delete_customer(customer, conn.assigns) do
      send_resp(conn, :no_content, "")
    end
  end
end
