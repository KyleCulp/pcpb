defmodule Pcpb.Parts do
  @moduledoc """
  The Parts context.
  """

  import Ecto.Query, warn: false
  alias Pcpb.Repo

  alias Pcpb.Parts.CPU

  @doc """
  Returns a unique, url safe id.
  """
  def get_id do
    Repo.all(CPU)
  end

  @doc """
  Returns the list of cpus.

  ## Examples

      iex> list_cpus()
      [%CPU{}, ...]

  """
  def list_cpus do
    Repo.all(CPU)
  end

  @doc """
  Gets a single cpu.

  Raises `Ecto.NoResultsError` if the Cpu does not exist.

  ## Examples

      iex> get_cpu!(123)
      %CPU{}

      iex> get_cpu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cpu!(id), do: Repo.get!(CPU, id)

  @doc """
  Creates a cpu.

  ## Examples

      iex> create_cpu(%{field: value})
      {:ok, %CPU{}}

      iex> create_cpu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cpu(attrs \\ %{}) do
    %CPU{}
    |> CPU.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cpu.

  ## Examples

      iex> update_cpu(cpu, %{field: new_value})
      {:ok, %CPU{}}

      iex> update_cpu(cpu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cpu(%CPU{} = cpu, attrs) do
    cpu
    |> CPU.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cpu.

  ## Examples

      iex> delete_cpu(cpu)
      {:ok, %CPU{}}

      iex> delete_cpu(cpu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cpu(%CPU{} = cpu) do
    Repo.delete(cpu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cpu changes.

  ## Examples

      iex> change_cpu(cpu)
      %Ecto.Changeset{data: %CPU{}}

  """
  def change_cpu(%CPU{} = cpu, attrs \\ %{}) do
    CPU.changeset(cpu, attrs)
  end

  alias Pcpb.Parts.Part

  @doc """
  Returns the list of parts.

  ## Examples

      iex> list_parts()
      [%Part{}, ...]

  """
  def list_parts do
    Repo.all(Part)
  end

  @doc """
  Gets a single part.

  Raises `Ecto.NoResultsError` if the Part does not exist.

  ## Examples

      iex> get_part!(123)
      %Part{}

      iex> get_part!(456)
      ** (Ecto.NoResultsError)

  """
  def get_part!(id), do: Repo.get!(Part, id)

  @doc """
  Creates a part.

  ## Examples

      iex> create_part(%{field: value})
      {:ok, %Part{}}

      iex> create_part(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_part(attrs \\ %{}) do
    %Part{}
    |> Part.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a part.

  ## Examples

      iex> update_part(part, %{field: new_value})
      {:ok, %Part{}}

      iex> update_part(part, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_part(%Part{} = part, attrs) do
    part
    |> Part.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a part.

  ## Examples

      iex> delete_part(part)
      {:ok, %Part{}}

      iex> delete_part(part)
      {:error, %Ecto.Changeset{}}

  """
  def delete_part(%Part{} = part) do
    Repo.delete(part)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking part changes.

  ## Examples

      iex> change_part(part)
      %Ecto.Changeset{data: %Part{}}

  """
  def change_part(%Part{} = part, attrs \\ %{}) do
    Part.changeset(part, attrs)
  end

  alias Pcpb.Parts.Case
  import Ecto.Query, only: [from: 2]

  # sort through a list of arrays of string, put unique values into a map
  def list_case_suggestions do
    query = "SELECT ARRAY(
      SELECT DISTINCT e
      FROM cases AS b
      CROSS JOIN LATERAL unnest(motherboard_support) AS a(e)
      -- ORDER BY e; -- if you want it sorted
    ) as motherboard_support"

    # from u in "cases",
    #   select: u.motherboard_support

    # "SELECT ARRAY(
    #   SELECT DISTINCT e
    #   FROM cases AS t
    #   CROSS JOIN LATERAL unnest(motherboard_support) AS a(e)
    #   ORDER BY e
    # );"
    data =
      Ecto.Adapters.SQL.query!(
        Pcpb.Repo,
        "SELECT ARRAY(
        SELECT DISTINCT e
        FROM cases AS b
        CROSS JOIN LATERAL unnest(motherboard_support) AS a(e)
        -- ORDER BY e; -- if you want it sorted
      ) as motherboard_support"
      )

    # data = Repo.all(query)
    # List.to_tuple(data)
    data.rows
    |> List.flatten()
    |> Enum.chunk_every(1)
    |> Enum.map(fn [a] -> {a, a} end)
    |> Map.new()
    |> IO.inspect()

    # data.rows
    # |> Enum.chunk_every(1)
    # |> Enum.map(fn [a] -> {a, a} end)
    # |> Map.new()
    # |> IO.inspect()
  end

  @doc """
  Returns the list of cases.

  ## Examples

      iex> list_cases()
      [%Case{}, ...]

  """
  def list_cases do
    Repo.all(Case)
  end

  @doc """
  Gets a single case.

  Raises `Ecto.NoResultsError` if the Case does not exist.

  ## Examples

      iex> get_case!(123)
      %Case{}

      iex> get_case!(456)
      ** (Ecto.NoResultsError)

  """
  def get_case!(id), do: Repo.get!(Case, id)

  @doc """
  Creates a case.

  ## Examples

      iex> create_case(%{field: value})
      {:ok, %Case{}}

      iex> create_case(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_case(attrs \\ %{}) do
    %Case{}
    |> Case.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a case.

  ## Examples

      iex> update_case(case, %{field: new_value})
      {:ok, %Case{}}

      iex> update_case(case, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_case(%Case{} = case, attrs) do
    case
    |> Case.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a case.

  ## Examples

      iex> delete_case(case)
      {:ok, %Case{}}

      iex> delete_case(case)
      {:error, %Ecto.Changeset{}}

  """
  def delete_case(%Case{} = case) do
    Repo.delete(case)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking case changes.

  ## Examples

      iex> change_case(case)
      %Ecto.Changeset{data: %Case{}}

  """
  def change_case(%Case{} = case, attrs \\ %{}) do
    Case.changeset(case, attrs)
  end

  alias Pcpb.Parts.CPUCooler

  @doc """
  Returns the list of cpu_coolers.

  ## Examples

      iex> list_cpu_coolers()
      [%CPUCooler{}, ...]

  """
  def list_cpu_coolers do
    Repo.all(CPUCooler)
  end

  @doc """
  Gets a single cpu_cooler.

  Raises `Ecto.NoResultsError` if the Cpu cooler does not exist.

  ## Examples

      iex> get_cpu_cooler!(123)
      %CPUCooler{}

      iex> get_cpu_cooler!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cpu_cooler!(id), do: Repo.get!(CPUCooler, id)

  @doc """
  Creates a cpu_cooler.

  ## Examples

      iex> create_cpu_cooler(%{field: value})
      {:ok, %CPUCooler{}}

      iex> create_cpu_cooler(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cpu_cooler(attrs \\ %{}) do
    %CPUCooler{}
    |> CPUCooler.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cpu_cooler.

  ## Examples

      iex> update_cpu_cooler(cpu_cooler, %{field: new_value})
      {:ok, %CPUCooler{}}

      iex> update_cpu_cooler(cpu_cooler, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cpu_cooler(%CPUCooler{} = cpu_cooler, attrs) do
    cpu_cooler
    |> CPUCooler.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cpu_cooler.

  ## Examples

      iex> delete_cpu_cooler(cpu_cooler)
      {:ok, %CPUCooler{}}

      iex> delete_cpu_cooler(cpu_cooler)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cpu_cooler(%CPUCooler{} = cpu_cooler) do
    Repo.delete(cpu_cooler)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cpu_cooler changes.

  ## Examples

      iex> change_cpu_cooler(cpu_cooler)
      %Ecto.Changeset{data: %CPUCooler{}}

  """
  def change_cpu_cooler(%CPUCooler{} = cpu_cooler, attrs \\ %{}) do
    CPUCooler.changeset(cpu_cooler, attrs)
  end
end
