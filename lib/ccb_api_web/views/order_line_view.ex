defmodule CcbApiWeb.OrderLineView do
  use CcbApiWeb, :view
  alias CcbApiWeb.OrderLineView

  def render("index.json", %{order_lines: order_lines}) do
    %{data: render_many(order_lines, OrderLineView, "order_line.json")}
  end

  def render("show.json", %{order_line: order_line}) do
    %{data: render_one(order_line, OrderLineView, "order_line.json")}
  end

  def render("order_line.json", %{order_line: order_line}) do
    %{id: order_line.id, quantity: order_line.quantity}
  end
end
