defmodule CcbApiWeb.ItemView do
  use CcbApiWeb, :view
  alias CcbApiWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item = %{product: %{title: title, description: description}}}) do
    %{
      id: item.id,
      sku: item.sku,
      quantity: item.quantity,
      product: %{title: title, description: description}
    }
  end
end
