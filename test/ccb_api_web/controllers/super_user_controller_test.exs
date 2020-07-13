defmodule CcbApiWeb.SuperUserControllerTest do
  use CcbApiWeb.ConnCase

  alias CcbApi.Accounts
  alias CcbApi.Accounts.SuperUser

  @create_attrs %{
    email: "some email"
  }
  @update_attrs %{
    email: "some updated email"
  }
  @invalid_attrs %{email: nil}

  def fixture(:super_user) do
    {:ok, super_user} = Accounts.create_super_user(@create_attrs)
    super_user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all super_users", %{conn: conn} do
      conn = get(conn, Routes.super_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create super_user" do
    test "renders super_user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.super_user_path(conn, :create), super_user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.super_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.super_user_path(conn, :create), super_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update super_user" do
    setup [:create_super_user]

    test "renders super_user when data is valid", %{
      conn: conn,
      super_user: %SuperUser{id: id} = super_user
    } do
      conn =
        put(conn, Routes.super_user_path(conn, :update, super_user), super_user: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.super_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, super_user: super_user} do
      conn =
        put(conn, Routes.super_user_path(conn, :update, super_user), super_user: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete super_user" do
    setup [:create_super_user]

    test "deletes chosen super_user", %{conn: conn, super_user: super_user} do
      conn = delete(conn, Routes.super_user_path(conn, :delete, super_user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.super_user_path(conn, :show, super_user))
      end
    end
  end

  defp create_super_user(_) do
    super_user = fixture(:super_user)
    %{super_user: super_user}
  end
end
