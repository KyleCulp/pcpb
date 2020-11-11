defmodule Pcpb.Parts do
  @moduledoc """
  The Parts context.
  """

  import Ecto.Query, warn: false
  alias Pcpb.Repo

  alias Pcpb.Parts.CPU

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
end
