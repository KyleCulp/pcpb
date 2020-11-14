defmodule Pcpb.PartsTest do
  use Pcpb.DataCase

  alias Pcpb.Parts

  describe "cpus" do
    alias Pcpb.Parts.CPU

    @valid_attrs %{boost_clock: 42, boost_tdp: 42, cache: "some cache", core_clock: 42, core_count: 42, family: "some family", integrated_graphics: "some integrated_graphics", lithography: "some lithography", manufacturer: "some manufacturer", max_memory: 42, memory_channels: 42, model: "some model", model_year: "some model_year", name: "some name", series: "some series", simultaneous_multithreading: "some simultaneous_multithreading", stock_cooler: "some stock_cooler", tdp: 42}
    @update_attrs %{boost_clock: 43, boost_tdp: 43, cache: "some updated cache", core_clock: 43, core_count: 43, family: "some updated family", integrated_graphics: "some updated integrated_graphics", lithography: "some updated lithography", manufacturer: "some updated manufacturer", max_memory: 43, memory_channels: 43, model: "some updated model", model_year: "some updated model_year", name: "some updated name", series: "some updated series", simultaneous_multithreading: "some updated simultaneous_multithreading", stock_cooler: "some updated stock_cooler", tdp: 43}
    @invalid_attrs %{boost_clock: nil, boost_tdp: nil, cache: nil, core_clock: nil, core_count: nil, family: nil, integrated_graphics: nil, lithography: nil, manufacturer: nil, max_memory: nil, memory_channels: nil, model: nil, model_year: nil, name: nil, series: nil, simultaneous_multithreading: nil, stock_cooler: nil, tdp: nil}

    def cpu_fixture(attrs \\ %{}) do
      {:ok, cpu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_cpu()

      cpu
    end

    test "list_cpus/0 returns all cpus" do
      cpu = cpu_fixture()
      assert Parts.list_cpus() == [cpu]
    end

    test "get_cpu!/1 returns the cpu with given id" do
      cpu = cpu_fixture()
      assert Parts.get_cpu!(cpu.id) == cpu
    end

    test "create_cpu/1 with valid data creates a cpu" do
      assert {:ok, %CPU{} = cpu} = Parts.create_cpu(@valid_attrs)
      assert cpu.boost_clock == 42
      assert cpu.boost_tdp == 42
      assert cpu.cache == "some cache"
      assert cpu.core_clock == 42
      assert cpu.core_count == 42
      assert cpu.family == "some family"
      assert cpu.integrated_graphics == "some integrated_graphics"
      assert cpu.lithography == "some lithography"
      assert cpu.manufacturer == "some manufacturer"
      assert cpu.max_memory == 42
      assert cpu.memory_channels == 42
      assert cpu.model == "some model"
      assert cpu.model_year == "some model_year"
      assert cpu.name == "some name"
      assert cpu.series == "some series"
      assert cpu.simultaneous_multithreading == "some simultaneous_multithreading"
      assert cpu.stock_cooler == "some stock_cooler"
      assert cpu.tdp == 42
    end

    test "create_cpu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_cpu(@invalid_attrs)
    end

    test "update_cpu/2 with valid data updates the cpu" do
      cpu = cpu_fixture()
      assert {:ok, %CPU{} = cpu} = Parts.update_cpu(cpu, @update_attrs)
      assert cpu.boost_clock == 43
      assert cpu.boost_tdp == 43
      assert cpu.cache == "some updated cache"
      assert cpu.core_clock == 43
      assert cpu.core_count == 43
      assert cpu.family == "some updated family"
      assert cpu.integrated_graphics == "some updated integrated_graphics"
      assert cpu.lithography == "some updated lithography"
      assert cpu.manufacturer == "some updated manufacturer"
      assert cpu.max_memory == 43
      assert cpu.memory_channels == 43
      assert cpu.model == "some updated model"
      assert cpu.model_year == "some updated model_year"
      assert cpu.name == "some updated name"
      assert cpu.series == "some updated series"
      assert cpu.simultaneous_multithreading == "some updated simultaneous_multithreading"
      assert cpu.stock_cooler == "some updated stock_cooler"
      assert cpu.tdp == 43
    end

    test "update_cpu/2 with invalid data returns error changeset" do
      cpu = cpu_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_cpu(cpu, @invalid_attrs)
      assert cpu == Parts.get_cpu!(cpu.id)
    end

    test "delete_cpu/1 deletes the cpu" do
      cpu = cpu_fixture()
      assert {:ok, %CPU{}} = Parts.delete_cpu(cpu)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_cpu!(cpu.id) end
    end

    test "change_cpu/1 returns a cpu changeset" do
      cpu = cpu_fixture()
      assert %Ecto.Changeset{} = Parts.change_cpu(cpu)
    end
  end

  describe "parts" do
    alias Pcpb.Parts.Part

    @valid_attrs %{name: "some name", partid: 42}
    @update_attrs %{name: "some updated name", partid: 43}
    @invalid_attrs %{name: nil, partid: nil}

    def part_fixture(attrs \\ %{}) do
      {:ok, part} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_part()

      part
    end

    test "list_parts/0 returns all parts" do
      part = part_fixture()
      assert Parts.list_parts() == [part]
    end

    test "get_part!/1 returns the part with given id" do
      part = part_fixture()
      assert Parts.get_part!(part.id) == part
    end

    test "create_part/1 with valid data creates a part" do
      assert {:ok, %Part{} = part} = Parts.create_part(@valid_attrs)
      assert part.name == "some name"
      assert part.partid == 42
    end

    test "create_part/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_part(@invalid_attrs)
    end

    test "update_part/2 with valid data updates the part" do
      part = part_fixture()
      assert {:ok, %Part{} = part} = Parts.update_part(part, @update_attrs)
      assert part.name == "some updated name"
      assert part.partid == 43
    end

    test "update_part/2 with invalid data returns error changeset" do
      part = part_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_part(part, @invalid_attrs)
      assert part == Parts.get_part!(part.id)
    end

    test "delete_part/1 deletes the part" do
      part = part_fixture()
      assert {:ok, %Part{}} = Parts.delete_part(part)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_part!(part.id) end
    end

    test "change_part/1 returns a part changeset" do
      part = part_fixture()
      assert %Ecto.Changeset{} = Parts.change_part(part)
    end
  end
end
