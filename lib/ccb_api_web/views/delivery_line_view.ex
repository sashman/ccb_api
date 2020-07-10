defmodule CcbApiWeb.DeliveryLineView do
  use CcbApiWeb, :view
  alias CcbApiWeb.DeliveryLineView

  def render("index.json", %{delivery_lines: delivery_lines}) do
    %{data: render_many(delivery_lines, DeliveryLineView, "delivery_line.json")}
  end

  def render("show.json", %{delivery_line: delivery_line}) do
    %{data: render_one(delivery_line, DeliveryLineView, "delivery_line.json")}
  end

  def render("delivery_line.json", %{delivery_line: delivery_line}) do
    %{id: delivery_line.id, quantity: delivery_line.quantity}
  end
end
