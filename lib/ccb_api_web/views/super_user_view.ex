defmodule CcbApiWeb.SuperUserView do
  use CcbApiWeb, :view
  alias CcbApiWeb.SuperUserView

  def render("index.json", %{super_users: super_users}) do
    %{data: render_many(super_users, SuperUserView, "super_user.json")}
  end

  def render("show.json", %{super_user: super_user}) do
    %{data: render_one(super_user, SuperUserView, "super_user.json")}
  end

  def render("super_user.json", %{super_user: super_user}) do
    %{id: super_user.id,
      email: super_user.email}
  end
end
