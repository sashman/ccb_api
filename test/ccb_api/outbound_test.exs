defmodule CcbApi.OutboundTest do
  use CcbApi.DataCase

  alias CcbApi.Outbound

  describe "orders" do
    alias CcbApi.Outbound.Order

    @valid_attrs %{
      channel_reference: "some channel_reference",
      external_id: "some external_id",
      shipping_status: "some shipping_status"
    }
    @update_attrs %{
      channel_reference: "some updated channel_reference",
      external_id: "some updated external_id",
      shipping_status: "some updated shipping_status"
    }
    @invalid_attrs %{channel_reference: nil, external_id: nil, shipping_status: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Outbound.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Outbound.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Outbound.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Outbound.create_order(@valid_attrs)
      assert order.channel_reference == "some channel_reference"
      assert order.external_id == "some external_id"
      assert order.shipping_status == "some shipping_status"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Outbound.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Outbound.update_order(order, @update_attrs)
      assert order.channel_reference == "some updated channel_reference"
      assert order.external_id == "some updated external_id"
      assert order.shipping_status == "some updated shipping_status"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Outbound.update_order(order, @invalid_attrs)
      assert order == Outbound.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Outbound.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Outbound.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Outbound.change_order(order)
    end
  end

  describe "order_lines" do
    alias CcbApi.Outbound.OrderLine

    @valid_attrs %{quantity: 42}
    @update_attrs %{quantity: 43}
    @invalid_attrs %{quantity: nil}

    def order_line_fixture(attrs \\ %{}) do
      {:ok, order_line} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Outbound.create_order_line()

      order_line
    end

    test "list_order_lines/0 returns all order_lines" do
      order_line = order_line_fixture()
      assert Outbound.list_order_lines() == [order_line]
    end

    test "get_order_line!/1 returns the order_line with given id" do
      order_line = order_line_fixture()
      assert Outbound.get_order_line!(order_line.id) == order_line
    end

    test "create_order_line/1 with valid data creates a order_line" do
      assert {:ok, %OrderLine{} = order_line} = Outbound.create_order_line(@valid_attrs)
      assert order_line.quantity == 42
    end

    test "create_order_line/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Outbound.create_order_line(@invalid_attrs)
    end

    test "update_order_line/2 with valid data updates the order_line" do
      order_line = order_line_fixture()

      assert {:ok, %OrderLine{} = order_line} =
               Outbound.update_order_line(order_line, @update_attrs)

      assert order_line.quantity == 43
    end

    test "update_order_line/2 with invalid data returns error changeset" do
      order_line = order_line_fixture()
      assert {:error, %Ecto.Changeset{}} = Outbound.update_order_line(order_line, @invalid_attrs)
      assert order_line == Outbound.get_order_line!(order_line.id)
    end

    test "delete_order_line/1 deletes the order_line" do
      order_line = order_line_fixture()
      assert {:ok, %OrderLine{}} = Outbound.delete_order_line(order_line)
      assert_raise Ecto.NoResultsError, fn -> Outbound.get_order_line!(order_line.id) end
    end

    test "change_order_line/1 returns a order_line changeset" do
      order_line = order_line_fixture()
      assert %Ecto.Changeset{} = Outbound.change_order_line(order_line)
    end
  end
end
