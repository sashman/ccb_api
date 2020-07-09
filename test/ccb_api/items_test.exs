defmodule CcbApi.ItemsTest do
  use CcbApi.DataCase

  alias CcbApi.Items

  describe "products" do
    alias CcbApi.Items.Product

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Items.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Items.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Items.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.title == "some title"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Items.update_product(product, @update_attrs)
      assert product.description == "some updated description"
      assert product.title == "some updated title"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_product(product, @invalid_attrs)
      assert product == Items.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Items.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Items.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Items.change_product(product)
    end
  end

  describe "items" do
    alias CcbApi.Items.Item

    @valid_attrs %{quantity: 42, sku: "some sku"}
    @update_attrs %{quantity: 43, sku: "some updated sku"}
    @invalid_attrs %{quantity: nil, sku: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Items.create_item(@valid_attrs)
      assert item.quantity == 42
      assert item.sku == "some sku"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Items.update_item(item, @update_attrs)
      assert item.quantity == 43
      assert item.sku == "some updated sku"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end

  describe "item_options" do
    alias CcbApi.Items.ItemOption

    @valid_attrs %{name: "some name", value: "some value"}
    @update_attrs %{name: "some updated name", value: "some updated value"}
    @invalid_attrs %{name: nil, value: nil}

    def item_option_fixture(attrs \\ %{}) do
      {:ok, item_option} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_item_option()

      item_option
    end

    test "list_item_options/0 returns all item_options" do
      item_option = item_option_fixture()
      assert Items.list_item_options() == [item_option]
    end

    test "get_item_option!/1 returns the item_option with given id" do
      item_option = item_option_fixture()
      assert Items.get_item_option!(item_option.id) == item_option
    end

    test "create_item_option/1 with valid data creates a item_option" do
      assert {:ok, %ItemOption{} = item_option} = Items.create_item_option(@valid_attrs)
      assert item_option.name == "some name"
      assert item_option.value == "some value"
    end

    test "create_item_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item_option(@invalid_attrs)
    end

    test "update_item_option/2 with valid data updates the item_option" do
      item_option = item_option_fixture()

      assert {:ok, %ItemOption{} = item_option} =
               Items.update_item_option(item_option, @update_attrs)

      assert item_option.name == "some updated name"
      assert item_option.value == "some updated value"
    end

    test "update_item_option/2 with invalid data returns error changeset" do
      item_option = item_option_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item_option(item_option, @invalid_attrs)
      assert item_option == Items.get_item_option!(item_option.id)
    end

    test "delete_item_option/1 deletes the item_option" do
      item_option = item_option_fixture()
      assert {:ok, %ItemOption{}} = Items.delete_item_option(item_option)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item_option!(item_option.id) end
    end

    test "change_item_option/1 returns a item_option changeset" do
      item_option = item_option_fixture()
      assert %Ecto.Changeset{} = Items.change_item_option(item_option)
    end
  end
end
