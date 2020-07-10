defmodule CcbApi.InboundTest do
  use CcbApi.DataCase

  alias CcbApi.Inbound

  describe "deliveries" do
    alias CcbApi.Inbound.Delivery

    @valid_attrs %{quantity: 42}
    @update_attrs %{quantity: 43}
    @invalid_attrs %{quantity: nil}

    def delivery_fixture(attrs \\ %{}) do
      {:ok, delivery} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inbound.create_delivery()

      delivery
    end

    test "list_deliveries/0 returns all deliveries" do
      delivery = delivery_fixture()
      assert Inbound.list_deliveries() == [delivery]
    end

    test "get_delivery!/1 returns the delivery with given id" do
      delivery = delivery_fixture()
      assert Inbound.get_delivery!(delivery.id) == delivery
    end

    test "create_delivery/1 with valid data creates a delivery" do
      assert {:ok, %Delivery{} = delivery} = Inbound.create_delivery(@valid_attrs)
      assert delivery.quantity == 42
    end

    test "create_delivery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inbound.create_delivery(@invalid_attrs)
    end

    test "update_delivery/2 with valid data updates the delivery" do
      delivery = delivery_fixture()
      assert {:ok, %Delivery{} = delivery} = Inbound.update_delivery(delivery, @update_attrs)
      assert delivery.quantity == 43
    end

    test "update_delivery/2 with invalid data returns error changeset" do
      delivery = delivery_fixture()
      assert {:error, %Ecto.Changeset{}} = Inbound.update_delivery(delivery, @invalid_attrs)
      assert delivery == Inbound.get_delivery!(delivery.id)
    end

    test "delete_delivery/1 deletes the delivery" do
      delivery = delivery_fixture()
      assert {:ok, %Delivery{}} = Inbound.delete_delivery(delivery)
      assert_raise Ecto.NoResultsError, fn -> Inbound.get_delivery!(delivery.id) end
    end

    test "change_delivery/1 returns a delivery changeset" do
      delivery = delivery_fixture()
      assert %Ecto.Changeset{} = Inbound.change_delivery(delivery)
    end
  end

  describe "deliveries" do
    alias CcbApi.Inbound.Delivery

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def delivery_fixture(attrs \\ %{}) do
      {:ok, delivery} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inbound.create_delivery()

      delivery
    end

    test "list_deliveries/0 returns all deliveries" do
      delivery = delivery_fixture()
      assert Inbound.list_deliveries() == [delivery]
    end

    test "get_delivery!/1 returns the delivery with given id" do
      delivery = delivery_fixture()
      assert Inbound.get_delivery!(delivery.id) == delivery
    end

    test "create_delivery/1 with valid data creates a delivery" do
      assert {:ok, %Delivery{} = delivery} = Inbound.create_delivery(@valid_attrs)
    end

    test "create_delivery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inbound.create_delivery(@invalid_attrs)
    end

    test "update_delivery/2 with valid data updates the delivery" do
      delivery = delivery_fixture()
      assert {:ok, %Delivery{} = delivery} = Inbound.update_delivery(delivery, @update_attrs)
    end

    test "update_delivery/2 with invalid data returns error changeset" do
      delivery = delivery_fixture()
      assert {:error, %Ecto.Changeset{}} = Inbound.update_delivery(delivery, @invalid_attrs)
      assert delivery == Inbound.get_delivery!(delivery.id)
    end

    test "delete_delivery/1 deletes the delivery" do
      delivery = delivery_fixture()
      assert {:ok, %Delivery{}} = Inbound.delete_delivery(delivery)
      assert_raise Ecto.NoResultsError, fn -> Inbound.get_delivery!(delivery.id) end
    end

    test "change_delivery/1 returns a delivery changeset" do
      delivery = delivery_fixture()
      assert %Ecto.Changeset{} = Inbound.change_delivery(delivery)
    end
  end

  describe "delivery_lines" do
    alias CcbApi.Inbound.DeliveryLine

    @valid_attrs %{quantity: 42}
    @update_attrs %{quantity: 43}
    @invalid_attrs %{quantity: nil}

    def delivery_line_fixture(attrs \\ %{}) do
      {:ok, delivery_line} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inbound.create_delivery_line()

      delivery_line
    end

    test "list_delivery_lines/0 returns all delivery_lines" do
      delivery_line = delivery_line_fixture()
      assert Inbound.list_delivery_lines() == [delivery_line]
    end

    test "get_delivery_line!/1 returns the delivery_line with given id" do
      delivery_line = delivery_line_fixture()
      assert Inbound.get_delivery_line!(delivery_line.id) == delivery_line
    end

    test "create_delivery_line/1 with valid data creates a delivery_line" do
      assert {:ok, %DeliveryLine{} = delivery_line} = Inbound.create_delivery_line(@valid_attrs)
      assert delivery_line.quantity == 42
    end

    test "create_delivery_line/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inbound.create_delivery_line(@invalid_attrs)
    end

    test "update_delivery_line/2 with valid data updates the delivery_line" do
      delivery_line = delivery_line_fixture()

      assert {:ok, %DeliveryLine{} = delivery_line} =
               Inbound.update_delivery_line(delivery_line, @update_attrs)

      assert delivery_line.quantity == 43
    end

    test "update_delivery_line/2 with invalid data returns error changeset" do
      delivery_line = delivery_line_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Inbound.update_delivery_line(delivery_line, @invalid_attrs)

      assert delivery_line == Inbound.get_delivery_line!(delivery_line.id)
    end

    test "delete_delivery_line/1 deletes the delivery_line" do
      delivery_line = delivery_line_fixture()
      assert {:ok, %DeliveryLine{}} = Inbound.delete_delivery_line(delivery_line)
      assert_raise Ecto.NoResultsError, fn -> Inbound.get_delivery_line!(delivery_line.id) end
    end

    test "change_delivery_line/1 returns a delivery_line changeset" do
      delivery_line = delivery_line_fixture()
      assert %Ecto.Changeset{} = Inbound.change_delivery_line(delivery_line)
    end
  end
end
