defmodule CcbApiWeb.OrderLineController do
  use CcbApiWeb, :controller

  alias CcbApi.Outbound
  alias CcbApi.Outbound.OrderLine

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    order_lines = Outbound.list_order_lines()
    render(conn, "index.json", order_lines: order_lines)
  end

  def create(conn, %{"order_line" => order_line_params}) do
    with {:ok, %OrderLine{} = order_line} <- Outbound.create_order_line(order_line_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_line_path(conn, :show, order_line))
      |> render("show.json", order_line: order_line)
    end
  end

  def show(conn, %{"id" => id}) do
    order_line = Outbound.get_order_line!(id)
    render(conn, "show.json", order_line: order_line)
  end

  def update(conn, %{"id" => id, "order_line" => order_line_params}) do
    order_line = Outbound.get_order_line!(id)

    with {:ok, %OrderLine{} = order_line} <-
           Outbound.update_order_line(order_line, order_line_params) do
      render(conn, "show.json", order_line: order_line)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_line = Outbound.get_order_line!(id)

    with {:ok, %OrderLine{}} <- Outbound.delete_order_line(order_line) do
      send_resp(conn, :no_content, "")
    end
  end
end
