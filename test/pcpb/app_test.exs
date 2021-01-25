defmodule Pcpb.AppTest do
  use Pcpb.DataCase

  alias Pcpb.App

  describe "products" do
    alias Pcpb.App.Product

    @valid_attrs %{assigns: %{}, name: "some name", part: "some part"}
    @update_attrs %{assigns: %{}, name: "some updated name", part: "some updated part"}
    @invalid_attrs %{assigns: nil, name: nil, part: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert App.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert App.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = App.create_product(@valid_attrs)
      assert product.assigns == %{}
      assert product.name == "some name"
      assert product.part == "some part"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = App.update_product(product, @update_attrs)
      assert product.assigns == %{}
      assert product.name == "some updated name"
      assert product.part == "some updated part"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = App.update_product(product, @invalid_attrs)
      assert product == App.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = App.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> App.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = App.change_product(product)
    end
  end
end
