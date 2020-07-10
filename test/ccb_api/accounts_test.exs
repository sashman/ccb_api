defmodule CcbApi.AccountsTest do
  use CcbApi.DataCase

  alias CcbApi.Accounts

  describe "super_users" do
    alias CcbApi.Accounts.SuperUser

    @valid_attrs %{email: "some email"}
    @update_attrs %{email: "some updated email"}
    @invalid_attrs %{email: nil}

    def super_user_fixture(attrs \\ %{}) do
      {:ok, super_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_super_user()

      super_user
    end

    test "list_super_users/0 returns all super_users" do
      super_user = super_user_fixture()
      assert Accounts.list_super_users() == [super_user]
    end

    test "get_super_user!/1 returns the super_user with given id" do
      super_user = super_user_fixture()
      assert Accounts.get_super_user!(super_user.id) == super_user
    end

    test "create_super_user/1 with valid data creates a super_user" do
      assert {:ok, %SuperUser{} = super_user} = Accounts.create_super_user(@valid_attrs)
      assert super_user.email == "some email"
    end

    test "create_super_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_super_user(@invalid_attrs)
    end

    test "update_super_user/2 with valid data updates the super_user" do
      super_user = super_user_fixture()
      assert {:ok, %SuperUser{} = super_user} = Accounts.update_super_user(super_user, @update_attrs)
      assert super_user.email == "some updated email"
    end

    test "update_super_user/2 with invalid data returns error changeset" do
      super_user = super_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_super_user(super_user, @invalid_attrs)
      assert super_user == Accounts.get_super_user!(super_user.id)
    end

    test "delete_super_user/1 deletes the super_user" do
      super_user = super_user_fixture()
      assert {:ok, %SuperUser{}} = Accounts.delete_super_user(super_user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_super_user!(super_user.id) end
    end

    test "change_super_user/1 returns a super_user changeset" do
      super_user = super_user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_super_user(super_user)
    end
  end
end
