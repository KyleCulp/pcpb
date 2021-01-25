defmodule Pcpb.Parts do
  @moduledoc """
  The Parts context.
  """

  import Ecto.Query, warn: false
  alias Pcpb.Repo

  @parts_list ["cpus", "cpu_coolers", "cases", "memorys", "gpus", "psus"]
  alias Pcpb.Parts.Media

  # refactor this to not be so meh
  def generate_part_id do
    id = Nanoid.generate()
    duplicate = false

    for option <- @parts_list do
      query = Ecto.Query.from(a in "#{option}", where: a.id == ^id)

      if !Repo.exists?(query) do
        duplicate = true
      end
    end

    cond do
      duplicate -> generate_part_id()
      !duplicate -> id
    end
  end

  alias Pcpb.Parts.{CPU, CPUCooler, Case, GPU, Memory, PSU}

  def generate_part_id(part_type) do

    # this code is from before I made the part alias system... so it's bad,  but still works.

    id = Nanoid.generate(8)
    duplicate = false

    # for option <- @parts_list do
    #   query = Ecto.Query.from(a in "#{option}", where: a.id == ^id)

    #   if Repo.exists?(query) do
    #     duplicate = true
    #   end
    # end

    cond do
      duplicate -> generate_part_id(part_type)
      !duplicate -> id
    end
  end


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
    create_part(%{id: attrs.id, part_type: :cpu})

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

  alias Pcpb.Parts.Case

  # TODO: Refactor this so that you actually understand it, because days later it's still magic
  def autocomplete_lists(table, columns) do
    select_list =
      Enum.map(columns, fn k ->
        String.to_existing_atom(k)
      end)

    query = from p in table, select: map(p, ^select_list)

    query
    |> distinct(true)
    |> Repo.all()
    |> Enum.reduce(%{}, fn m, acc ->
      Map.merge(acc, m, fn _k, v1, v2 ->
        # Return an array of unique values and stuff, kinda magic and half stack overflow
        Enum.uniq([v1, v2])
      end)
    end)
  end

  # first implementation of autocomplete, had to learn ecto stuff to do above.
  # def simple_autocomplete_lists(table, columns) do
  #   columns_data = []

  #   columns_data =
  #     for column <- columns do
  #       # highly inefficient code but it really doesn't matter for admin panel use... yet
  #       data =
  #         Ecto.Adapters.SQL.query!(
  #           Pcpb.Repo,
  #           "
  #         SELECT
  #            DISTINCT #{column}
  #         FROM
  #         #{table};"
  #         )

  #       columns_data = columns_data ++ {String.to_atom(column), List.flatten(data.rows)}
  #     end
  #   columns_data |> Enum.into(%{})
  # end

  def list_array_suggestions(table, columns) do
    columns_data = []

    columns_data =
      for column <- columns do
        data =
          Ecto.Adapters.SQL.query!(
            Pcpb.Repo,
            "SELECT ARRAY(
          SELECT DISTINCT e
          FROM #{table} AS b
          CROSS JOIN LATERAL unnest(#{column}) AS a(e)
          ORDER BY e -- if you want it sorted
        ) as #{column}"
          )

        columns_data =
          columns_data ++ {String.to_atom(column), data.rows |> List.flatten() |> Enum.join(", ")}
      end

    columns_data |> Enum.into(%{})
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
    create_part(%{id: attrs.id, part_type: :case})

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
    create_part(%{id: attrs.id, part_type: :cpu_cooler})

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

  alias Pcpb.Parts.GPU

  @doc """
  Returns the list of gpus.

  ## Examples

      iex> list_gpus()
      [%GPU{}, ...]

  """
  def list_gpus do
    Repo.all(GPU)
  end

  @doc """
  Gets a single gpu.

  Raises `Ecto.NoResultsError` if the Gpu does not exist.

  ## Examples

      iex> get_gpu!(123)
      %GPU{}

      iex> get_gpu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gpu!(id), do: Repo.get!(GPU, id)

  @doc """
  Creates a gpu.

  ## Examples

      iex> create_gpu(%{field: value})
      {:ok, %GPU{}}

      iex> create_gpu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gpu(attrs \\ %{}) do
    create_part(%{id: attrs.id, part_type: :gpu})

    %GPU{}
    |> GPU.changeset(attrs)
    |> Repo.insert()

  end

  @doc """
  Updates a gpu.

  ## Examples

      iex> update_gpu(gpu, %{field: new_value})
      {:ok, %GPU{}}

      iex> update_gpu(gpu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gpu(%GPU{} = gpu, attrs) do
    gpu
    |> GPU.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gpu.

  ## Examples

      iex> delete_gpu(gpu)
      {:ok, %GPU{}}

      iex> delete_gpu(gpu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gpu(%GPU{} = gpu) do
    Repo.delete(gpu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gpu changes.

  ## Examples

      iex> change_gpu(gpu)
      %Ecto.Changeset{data: %GPU{}}

  """
  def change_gpu(%GPU{} = gpu, attrs \\ %{}) do
    GPU.changeset(gpu, attrs)
  end

  alias Pcpb.Parts.Memory

  @doc """
  Returns the list of memorys.

  ## Examples

      iex> list_memorys()
      [%Memory{}, ...]

  """
  def list_memorys do
    Repo.all(Memory)
  end

  @doc """
  Gets a single memory.

  Raises `Ecto.NoResultsError` if the Memory does not exist.

  ## Examples

      iex> get_memory!(123)
      %Memory{}

      iex> get_memory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_memory!(id), do: Repo.get!(Memory, id)

  @doc """
  Creates a memory.

  ## Examples

      iex> create_memory(%{field: value})
      {:ok, %Memory{}}

      iex> create_memory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_memory(attrs \\ %{}) do
    create_part(%{id: attrs.id, part_type: :memory})

    %Memory{}
    |> Memory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a memory.

  ## Examples

      iex> update_memory(memory, %{field: new_value})
      {:ok, %Memory{}}

      iex> update_memory(memory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_memory(%Memory{} = memory, attrs) do
    memory
    |> Memory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a memory.

  ## Examples

      iex> delete_memory(memory)
      {:ok, %Memory{}}

      iex> delete_memory(memory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_memory(%Memory{} = memory) do
    Repo.delete(memory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking memory changes.

  ## Examples

      iex> change_memory(memory)
      %Ecto.Changeset{data: %Memory{}}

  """
  def change_memory(%Memory{} = memory, attrs \\ %{}) do
    Memory.changeset(memory, attrs)
  end

  alias Pcpb.Parts.PSU

  @doc """
  Returns the list of psus.

  ## Examples

      iex> list_psus()
      [%PSU{}, ...]

  """
  def list_psus do
    Repo.all(PSU)
  end

  @doc """
  Gets a single psu.

  Raises `Ecto.NoResultsError` if the Psu does not exist.

  ## Examples

      iex> get_psu!(123)
      %PSU{}

      iex> get_psu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_psu!(id), do: Repo.get!(PSU, id)

  @doc """
  Creates a psu.

  ## Examples

      iex> create_psu(%{field: value})
      {:ok, %PSU{}}

      iex> create_psu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_psu(attrs \\ %{}) do
    create_part(%{id: attrs.id, part_type: :psu})

    %PSU{}
    |> PSU.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a psu.

  ## Examples

      iex> update_psu(psu, %{field: new_value})
      {:ok, %PSU{}}

      iex> update_psu(psu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_psu(%PSU{} = psu, attrs) do
    psu
    |> PSU.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a psu.

  ## Examples

      iex> delete_psu(psu)
      {:ok, %PSU{}}

      iex> delete_psu(psu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_psu(%PSU{} = psu) do
    Repo.delete(psu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking psu changes.

  ## Examples

      iex> change_psu(psu)
      %Ecto.Changeset{data: %PSU{}}

  """
  def change_psu(%PSU{} = psu, attrs \\ %{}) do
    PSU.changeset(psu, attrs)
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

  def list_part_ids do
    Repo.all(from p in Part, select: p.id)
  end

  def list_part_ids(part_type) do
    Repo.all(from p in Part, where: p.part_type == ^part_type, select: p.id)
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

  alias Pcpb.Parts.Metadata

  @doc """
  Returns the list of metadatas.

  ## Examples

      iex> list_metadatas()
      [%Metadata{}, ...]

  """
  def list_metadatas do
    Repo.all(Metadata)
  end

  @doc """
  Gets a single metadata.

  Raises `Ecto.NoResultsError` if the Metadata does not exist.

  ## Examples

      iex> get_metadata!(123)
      %Metadata{}

      iex> get_metadata!(456)
      ** (Ecto.NoResultsError)

  """
  def get_metadata!(id), do: Repo.get!(Metadata, id)

  @doc """
  Creates a metadata.

  ## Examples

      iex> create_metadata(%{field: value})
      {:ok, %Metadata{}}

      iex> create_metadata(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_metadata(attrs \\ %{}) do
    %Metadata{}
    |> Metadata.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a metadata.

  ## Examples

      iex> update_metadata(metadata, %{field: new_value})
      {:ok, %Metadata{}}

      iex> update_metadata(metadata, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_metadata(%Metadata{} = metadata, attrs) do
    metadata
    |> Metadata.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a metadata.

  ## Examples

      iex> delete_metadata(metadata)
      {:ok, %Metadata{}}

      iex> delete_metadata(metadata)
      {:error, %Ecto.Changeset{}}

  """
  def delete_metadata(%Metadata{} = metadata) do
    Repo.delete(metadata)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking metadata changes.

  ## Examples

      iex> change_metadata(metadata)
      %Ecto.Changeset{data: %Metadata{}}

  """
  def change_metadata(%Metadata{} = metadata, attrs \\ %{}) do
    Metadata.changeset(metadata, attrs)
  end
end
