defmodule Pcpb.App do
  @moduledoc """
  The App context.
  """

  import Ecto.Query, warn: false
  alias Pcpb.Repo

  alias Pcpb.App.Product
  alias Pcpb.Parts


  #Duplicating code across modules, hmm
  # @part_aliases [
  #   {CPU, "01"},
  #   {CPUCooler, "02"},
  #   {Case, "03"},
  #   {GPU, "04"},
  #   {Memory, "05"},
  #   {PSU, "05"}
  # ]
  # @part_aliases [
  #   [:cpu, "01"],
  #   [:cpu_cooler, "02"],
  #   [:case, "03"],
  #   [:gpu, "04"],
  #   [:memory, "05"],
  #   [:psu, "06"]
  # ]


  alias Ecto.Multi

  def quicktest() do
    create_product(%{
      name: " gskill test",
      part_type: :cpu,
      part_id: "01dk3vyk",
      image: [
        %{id: "8cb7f28f-2633-4dae-9a59-f5ddac0d64a7", full: "yooo"}
      ]
    })
  end


  # def generate_product_id() do
  #   id = Nanoid.generate()
  #   duplicate = Repo.exists?(from p in Product, where: p.id == ^id)

  #   cond do
  #     duplicate -> generate_product_id()
  #     !duplicate -> id
  #   end
  # end

  def generate_product_id do
    id = Nanoid.generate()
    # duplicate = Repo.exists?(Product, id)

    # cond do
    #   duplicate -> generate_product_id()
    #   !duplicate -> id
    # end
  end




  alias Pcpb.Parts
  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id) do
    Product
    |> Repo.get!(id)
    |> get_product_part()
  end
  def get_product(id) do
    case Repo.get(Product, id) do
      nil -> nil
      product -> product |> get_product_part()
    end

  end

  alias Pcpb.Parts.{CPU, CPUCooler, Case, GPU, Memory, PSU}


  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)  |> Repo.preload(:part)
  end

  def list_products(category) do
    Repo.all(from p in Product, where: ^category == p.part_type)  |> Repo.preload(:part)
  end

  def get_product_part(product) do
    part =
      Enum.filter(Pcpb.PartsList.part_repos, fn [x, y] -> product.part_type == x end)
      |> List.flatten()
      |> Enum.at(1)
      |> Repo.get!(product.part_id)

    Map.put(product, :part, part)
  end


  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test_product(attrs \\ %{part_id: "01hcz1db", name: "CPU 2020 lol", part_type: :cpu}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def get_products do
    Repo.all(Product) |> Repo.preload(:part)
  end

  def create_product(attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_change(:id, generate_product_id)
    |> Repo.insert()
  end

  def create_product(%Product{} = product, attrs, after_save \\ &{:ok, &1}) do
    product
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_change(:id, generate_product_id)
    |> after_save(after_save)
    |> Repo.insert()
  end

    @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end
  def update_product(%Product{} = product, attrs, images) do
    product
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_change(:images, images)
    |> Repo.update()
  end

  def test_sort() do
    product = Repo.get!(Product, "jkazuk2u")
    product.images
    # firstItem = Enum.at(product.images, 2)
    # images = List.replace_at(product.images, 2, Enum.at(product.images, 1))
    # List.replace_at(images, 1, firstItem)
  end


  @doc """
  Swaps two items in a list by their index

  ## Examples
      iex> swap(list, 0, 2)
      {:ok, %Product{}}
  """
  def swap(list, pos1, pos2) do
    firstItem = Enum.at(list, pos1)
    list = List.replace_at(list, pos1, Enum.at(list, pos2))
    List.replace_at(list, pos2, firstItem)
  end

  def list_map_to_struct(list) do
    for item <- list do
      Map.from_struct(item)
    end
  end

  # putting my 1/3 cs degree to work /s
  def sort_map_by_idlist(map_list, id_list) do
    new_map_list = map_list
    map_list
    |> Enum.with_index()
    |> Enum.map(fn({item, index}) ->
      item_clone = List.pop_at(map_list, index)
      new_index = Enum.find_index(id_list, fn x ->
        x == item.id
      end)
      new_map_list = List.insert_at(new_map_list, new_index, item_clone)
    end)
    IO.inspect(new_map_list)

  end

  defp after_save({:ok, product}, func) do
    {:ok, _product} = func.(product)
  end
  defp after_save(error, _func), do: error



  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

end
