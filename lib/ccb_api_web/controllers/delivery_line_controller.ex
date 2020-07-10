defmodule CcbApiWeb.DeliveryLineController do
  use CcbApiWeb, :controller

  alias CcbApi.Inbound
  alias CcbApi.Inbound.DeliveryLine

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    delivery_lines = Inbound.list_delivery_lines()
    render(conn, "index.json", delivery_lines: delivery_lines)
  end

  def create(conn, %{"delivery_line" => delivery_line_params}) do
    with {:ok, %DeliveryLine{} = delivery_line} <-
           Inbound.create_delivery_line(delivery_line_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.delivery_line_path(conn, :show, delivery_line))
      |> render("show.json", delivery_line: delivery_line)
    end
  end

  def show(conn, %{"id" => id}) do
    delivery_line = Inbound.get_delivery_line!(id)
    render(conn, "show.json", delivery_line: delivery_line)
  end

  def update(conn, %{"id" => id, "delivery_line" => delivery_line_params}) do
    delivery_line = Inbound.get_delivery_line!(id)

    with {:ok, %DeliveryLine{} = delivery_line} <-
           Inbound.update_delivery_line(delivery_line, delivery_line_params) do
      render(conn, "show.json", delivery_line: delivery_line)
    end
  end

  def delete(conn, %{"id" => id}) do
    delivery_line = Inbound.get_delivery_line!(id)

    with {:ok, %DeliveryLine{}} <- Inbound.delete_delivery_line(delivery_line) do
      send_resp(conn, :no_content, "")
    end
  end
end
