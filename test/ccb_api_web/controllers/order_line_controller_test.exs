defmodule CcbApiWeb.OrderLineControllerTest do
  use CcbApiWeb.ConnCase

  alias CcbApi.Outbound
  alias CcbApi.Outbound.OrderLine

  @create_attrs %{
    quantity: 42
  }
  @update_attrs %{
    quantity: 43
  }
  @invalid_attrs %{quantity: nil}

  def fixture(:order_line) do
    {:ok, order_line} = Outbound.create_order_line(@create_attrs)
    order_line
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order_lines", %{conn: conn} do
      conn = get(conn, Routes.order_line_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order_line" do
    test "renders order_line when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_line_path(conn, :create), order_line: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_line_path(conn, :show, id))

      assert %{
               "id" => id,
               "quantity" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_line_path(conn, :create), order_line: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order_line" do
    setup [:create_order_line]

    test "renders order_line when data is valid", %{
      conn: conn,
      order_line: %OrderLine{id: id} = order_line
    } do
      conn =
        put(conn, Routes.order_line_path(conn, :update, order_line), order_line: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_line_path(conn, :show, id))

      assert %{
               "id" => id,
               "quantity" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order_line: order_line} do
      conn =
        put(conn, Routes.order_line_path(conn, :update, order_line), order_line: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order_line" do
    setup [:create_order_line]

    test "deletes chosen order_line", %{conn: conn, order_line: order_line} do
      conn = delete(conn, Routes.order_line_path(conn, :delete, order_line))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_line_path(conn, :show, order_line))
      end
    end
  end

  defp create_order_line(_) do
    order_line = fixture(:order_line)
    %{order_line: order_line}
  end
end
