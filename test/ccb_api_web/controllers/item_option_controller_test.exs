defmodule CcbApiWeb.ItemOptionControllerTest do
  use CcbApiWeb.ConnCase

  alias CcbApi.Items
  alias CcbApi.Items.ItemOption

  @create_attrs %{
    name: "some name",
    value: "some value"
  }
  @update_attrs %{
    name: "some updated name",
    value: "some updated value"
  }
  @invalid_attrs %{name: nil, value: nil}

  def fixture(:item_option) do
    {:ok, item_option} = Items.create_item_option(@create_attrs)
    item_option
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all item_options", %{conn: conn} do
      conn = get(conn, Routes.item_option_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create item_option" do
    test "renders item_option when data is valid", %{conn: conn} do
      conn = post(conn, Routes.item_option_path(conn, :create), item_option: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.item_option_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.item_option_path(conn, :create), item_option: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update item_option" do
    setup [:create_item_option]

    test "renders item_option when data is valid", %{
      conn: conn,
      item_option: %ItemOption{id: id} = item_option
    } do
      conn =
        put(conn, Routes.item_option_path(conn, :update, item_option), item_option: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.item_option_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, item_option: item_option} do
      conn =
        put(conn, Routes.item_option_path(conn, :update, item_option), item_option: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete item_option" do
    setup [:create_item_option]

    test "deletes chosen item_option", %{conn: conn, item_option: item_option} do
      conn = delete(conn, Routes.item_option_path(conn, :delete, item_option))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.item_option_path(conn, :show, item_option))
      end
    end
  end

  defp create_item_option(_) do
    item_option = fixture(:item_option)
    %{item_option: item_option}
  end
end
