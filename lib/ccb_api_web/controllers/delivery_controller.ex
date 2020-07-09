defmodule CcbApiWeb.DeliveryController do
  use CcbApiWeb, :controller

  alias CcbApi.Inbound
  alias CcbApi.Inbound.Delivery

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    deliveries = Inbound.list_deliveries()
    render(conn, "index.json", deliveries: deliveries)
  end

  def create(conn, %{"delivery" => delivery_params}) do
    with {:ok, %Delivery{} = delivery} <- Inbound.create_delivery(delivery_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.delivery_path(conn, :show, delivery))
      |> render("show.json", delivery: delivery)
    end
  end

  def show(conn, %{"id" => id}) do
    delivery = Inbound.get_delivery!(id)
    render(conn, "show.json", delivery: delivery)
  end

  def update(conn, %{"id" => id, "delivery" => delivery_params}) do
    delivery = Inbound.get_delivery!(id)

    with {:ok, %Delivery{} = delivery} <- Inbound.update_delivery(delivery, delivery_params) do
      render(conn, "show.json", delivery: delivery)
    end
  end

  def delete(conn, %{"id" => id}) do
    delivery = Inbound.get_delivery!(id)

    with {:ok, %Delivery{}} <- Inbound.delete_delivery(delivery) do
      send_resp(conn, :no_content, "")
    end
  end
end
