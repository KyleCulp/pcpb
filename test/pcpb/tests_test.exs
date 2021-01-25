defmodule Pcpb.TestsTest do
  use Pcpb.DataCase

  alias Pcpb.Tests

  describe "bigs" do
    alias Pcpb.Tests.Big

    @valid_attrs %{pciex16_slots: 42, pciex8: 42}
    @update_attrs %{pciex16_slots: 43, pciex8: 43}
    @invalid_attrs %{pciex16_slots: nil, pciex8: nil}

    def big_fixture(attrs \\ %{}) do
      {:ok, big} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tests.create_big()

      big
    end

    test "list_bigs/0 returns all bigs" do
      big = big_fixture()
      assert Tests.list_bigs() == [big]
    end

    test "get_big!/1 returns the big with given id" do
      big = big_fixture()
      assert Tests.get_big!(big.id) == big
    end

    test "create_big/1 with valid data creates a big" do
      assert {:ok, %Big{} = big} = Tests.create_big(@valid_attrs)
      assert big.pciex16_slots == 42
      assert big.pciex8 == 42
    end

    test "create_big/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tests.create_big(@invalid_attrs)
    end

    test "update_big/2 with valid data updates the big" do
      big = big_fixture()
      assert {:ok, %Big{} = big} = Tests.update_big(big, @update_attrs)
      assert big.pciex16_slots == 43
      assert big.pciex8 == 43
    end

    test "update_big/2 with invalid data returns error changeset" do
      big = big_fixture()
      assert {:error, %Ecto.Changeset{}} = Tests.update_big(big, @invalid_attrs)
      assert big == Tests.get_big!(big.id)
    end

    test "delete_big/1 deletes the big" do
      big = big_fixture()
      assert {:ok, %Big{}} = Tests.delete_big(big)
      assert_raise Ecto.NoResultsError, fn -> Tests.get_big!(big.id) end
    end

    test "change_big/1 returns a big changeset" do
      big = big_fixture()
      assert %Ecto.Changeset{} = Tests.change_big(big)
    end
  end

  describe "bigss" do
    alias Pcpb.Tests.Bigs

    @valid_attrs %{pciex16_slots: 42, pciex8: 42, "usb3.1_slots": 42}
    @update_attrs %{pciex16_slots: 43, pciex8: 43, "usb3.1_slots": 43}
    @invalid_attrs %{pciex16_slots: nil, pciex8: nil, "usb3.1_slots": nil}

    def bigs_fixture(attrs \\ %{}) do
      {:ok, bigs} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tests.create_bigs()

      bigs
    end

    test "list_bigss/0 returns all bigss" do
      bigs = bigs_fixture()
      assert Tests.list_bigss() == [bigs]
    end

    test "get_bigs!/1 returns the bigs with given id" do
      bigs = bigs_fixture()
      assert Tests.get_bigs!(bigs.id) == bigs
    end

    test "create_bigs/1 with valid data creates a bigs" do
      assert {:ok, %Bigs{} = bigs} = Tests.create_bigs(@valid_attrs)
      assert bigs.pciex16_slots == 42
      assert bigs.pciex8 == 42
      assert bigs.usb3.1_slots == 42
    end

    test "create_bigs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tests.create_bigs(@invalid_attrs)
    end

    test "update_bigs/2 with valid data updates the bigs" do
      bigs = bigs_fixture()
      assert {:ok, %Bigs{} = bigs} = Tests.update_bigs(bigs, @update_attrs)
      assert bigs.pciex16_slots == 43
      assert bigs.pciex8 == 43
      assert bigs.usb3.1_slots == 43
    end

    test "update_bigs/2 with invalid data returns error changeset" do
      bigs = bigs_fixture()
      assert {:error, %Ecto.Changeset{}} = Tests.update_bigs(bigs, @invalid_attrs)
      assert bigs == Tests.get_bigs!(bigs.id)
    end

    test "delete_bigs/1 deletes the bigs" do
      bigs = bigs_fixture()
      assert {:ok, %Bigs{}} = Tests.delete_bigs(bigs)
      assert_raise Ecto.NoResultsError, fn -> Tests.get_bigs!(bigs.id) end
    end

    test "change_bigs/1 returns a bigs changeset" do
      bigs = bigs_fixture()
      assert %Ecto.Changeset{} = Tests.change_bigs(bigs)
    end
  end
end
