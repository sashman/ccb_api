defmodule CcbApiWeb.OrderView do
  use CcbApiWeb, :view
  alias CcbApiWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      external_id: order.external_id,
      channel_reference: order.channel_reference,
      shipping_status: order.shipping_status
    }
  end
end
