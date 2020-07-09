defmodule CcbApiWeb.ProductView do
  use CcbApiWeb, :view
  alias CcbApiWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id, title: product.title, description: product.description}
  end
end
