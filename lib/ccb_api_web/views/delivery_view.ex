defmodule CcbApiWeb.DeliveryView do
  use CcbApiWeb, :view
  alias CcbApiWeb.DeliveryView

  def render("index.json", %{deliveries: deliveries}) do
    %{data: render_many(deliveries, DeliveryView, "delivery.json")}
  end

  def render("show.json", %{delivery: delivery}) do
    %{data: render_one(delivery, DeliveryView, "delivery.json")}
  end

  def render("delivery.json", %{delivery: delivery}) do
    %{id: delivery.id}
  end
end
