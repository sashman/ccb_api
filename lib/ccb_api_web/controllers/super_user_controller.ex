defmodule CcbApiWeb.SuperUserController do
  use CcbApiWeb, :controller

  alias CcbApi.Accounts
  alias CcbApi.Accounts.SuperUser

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    super_users = Accounts.list_super_users()
    render(conn, "index.json", super_users: super_users)
  end

  def create(conn, %{"super_user" => super_user_params}) do
    with {:ok, %SuperUser{} = super_user} <- Accounts.create_super_user(super_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.super_user_path(conn, :show, super_user))
      |> render("show.json", super_user: super_user)
    end
  end

  def show(conn, %{"id" => id}) do
    super_user = Accounts.get_super_user!(id)
    render(conn, "show.json", super_user: super_user)
  end

  def update(conn, %{"id" => id, "super_user" => super_user_params}) do
    super_user = Accounts.get_super_user!(id)

    with {:ok, %SuperUser{} = super_user} <- Accounts.update_super_user(super_user, super_user_params) do
      render(conn, "show.json", super_user: super_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    super_user = Accounts.get_super_user!(id)

    with {:ok, %SuperUser{}} <- Accounts.delete_super_user(super_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
