defmodule CcbApiWeb.ItemOptionView do
  use CcbApiWeb, :view
  alias CcbApiWeb.ItemOptionView

  def render("index.json", %{item_options: item_options}) do
    %{data: render_many(item_options, ItemOptionView, "item_option.json")}
  end

  def render("show.json", %{item_option: item_option}) do
    %{data: render_one(item_option, ItemOptionView, "item_option.json")}
  end

  def render("item_option.json", %{item_option: item_option}) do
    %{id: item_option.id, name: item_option.name, value: item_option.value}
  end
end
