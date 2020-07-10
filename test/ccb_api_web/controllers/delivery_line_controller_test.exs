defmodule CcbApiWeb.DeliveryLineControllerTest do
  use CcbApiWeb.ConnCase

  alias CcbApi.Inbound
  alias CcbApi.Inbound.DeliveryLine

  @create_attrs %{
    quantity: 42
  }
  @update_attrs %{
    quantity: 43
  }
  @invalid_attrs %{quantity: nil}

  def fixture(:delivery_line) do
    {:ok, delivery_line} = Inbound.create_delivery_line(@create_attrs)
    delivery_line
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all delivery_lines", %{conn: conn} do
      conn = get(conn, Routes.delivery_line_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create delivery_line" do
    test "renders delivery_line when data is valid", %{conn: conn} do
      conn = post(conn, Routes.delivery_line_path(conn, :create), delivery_line: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.delivery_line_path(conn, :show, id))

      assert %{
               "id" => id,
               "quantity" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.delivery_line_path(conn, :create), delivery_line: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update delivery_line" do
    setup [:create_delivery_line]

    test "renders delivery_line when data is valid", %{
      conn: conn,
      delivery_line: %DeliveryLine{id: id} = delivery_line
    } do
      conn =
        put(conn, Routes.delivery_line_path(conn, :update, delivery_line),
          delivery_line: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.delivery_line_path(conn, :show, id))

      assert %{
               "id" => id,
               "quantity" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, delivery_line: delivery_line} do
      conn =
        put(conn, Routes.delivery_line_path(conn, :update, delivery_line),
          delivery_line: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete delivery_line" do
    setup [:create_delivery_line]

    test "deletes chosen delivery_line", %{conn: conn, delivery_line: delivery_line} do
      conn = delete(conn, Routes.delivery_line_path(conn, :delete, delivery_line))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.delivery_line_path(conn, :show, delivery_line))
      end
    end
  end

  defp create_delivery_line(_) do
    delivery_line = fixture(:delivery_line)
    %{delivery_line: delivery_line}
  end
end
