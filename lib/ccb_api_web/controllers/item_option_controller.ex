defmodule CcbApiWeb.ItemOptionController do
  use CcbApiWeb, :controller

  alias CcbApi.Items
  alias CcbApi.Items.ItemOption

  action_fallback CcbApiWeb.FallbackController

  def index(conn, _params) do
    item_options = Items.list_item_options()
    render(conn, "index.json", item_options: item_options)
  end

  def create(conn, %{"item_option" => item_option_params}) do
    with {:ok, %ItemOption{} = item_option} <- Items.create_item_option(item_option_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.item_option_path(conn, :show, item_option))
      |> render("show.json", item_option: item_option)
    end
  end

  def show(conn, %{"id" => id}) do
    item_option = Items.get_item_option!(id)
    render(conn, "show.json", item_option: item_option)
  end

  def update(conn, %{"id" => id, "item_option" => item_option_params}) do
    item_option = Items.get_item_option!(id)

    with {:ok, %ItemOption{} = item_option} <-
           Items.update_item_option(item_option, item_option_params) do
      render(conn, "show.json", item_option: item_option)
    end
  end

  def delete(conn, %{"id" => id}) do
    item_option = Items.get_item_option!(id)

    with {:ok, %ItemOption{}} <- Items.delete_item_option(item_option) do
      send_resp(conn, :no_content, "")
    end
  end
end
