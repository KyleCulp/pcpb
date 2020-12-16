defmodule Pcpb.PartsTest do
  use Pcpb.DataCase

  alias Pcpb.Parts

  describe "cpus" do
    alias Pcpb.Parts.CPU

    @valid_attrs %{
      boost_clock: 42,
      boost_tdp: 42,
      cache: "some cache",
      core_clock: 42,
      core_count: 42,
      family: "some family",
      integrated_graphics: "some integrated_graphics",
      lithography: "some lithography",
      manufacturer: "some manufacturer",
      max_memory: 42,
      memory_channels: 42,
      model: "some model",
      model_year: "some model_year",
      name: "some name",
      series: "some series",
      smt: "some smt",
      stock_cooler: "some stock_cooler",
      tdp: 42
    }
    @update_attrs %{
      boost_clock: 43,
      boost_tdp: 43,
      cache: "some updated cache",
      core_clock: 43,
      core_count: 43,
      family: "some updated family",
      integrated_graphics: "some updated integrated_graphics",
      lithography: "some updated lithography",
      manufacturer: "some updated manufacturer",
      max_memory: 43,
      memory_channels: 43,
      model: "some updated model",
      model_year: "some updated model_year",
      name: "some updated name",
      series: "some updated series",
      smt: "some updated smt",
      stock_cooler: "some updated stock_cooler",
      tdp: 43
    }
    @invalid_attrs %{
      boost_clock: nil,
      boost_tdp: nil,
      cache: nil,
      core_clock: nil,
      core_count: nil,
      family: nil,
      integrated_graphics: nil,
      lithography: nil,
      manufacturer: nil,
      max_memory: nil,
      memory_channels: nil,
      model: nil,
      model_year: nil,
      name: nil,
      series: nil,
      smt: nil,
      stock_cooler: nil,
      tdp: nil
    }

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
      assert cpu.smt == "some smt"
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
      assert cpu.smt == "some updated smt"
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

  describe "cases" do
    alias Pcpb.Parts.Case

    @valid_attrs %{
      clearance: %{},
      color: "some color",
      dimensions: %{},
      dust_filters: %{},
      expansion_slots: %{},
      fan_options: %{},
      included_psu: "some included_psu",
      io: %{},
      manufacturer: "some manufacturer",
      model: "some model",
      model_number: "some model_number",
      motherboard_support: [],
      name: "some name",
      psu_mount_location: "some psu_mount_location",
      psu_shroud: "some psu_shroud",
      psu_support: [],
      radiator_support: %{},
      release: ~D[2010-04-17],
      type: "some type",
      weight: "120.5",
      windows: %{}
    }
    @update_attrs %{
      clearance: %{},
      color: "some updated color",
      dimensions: %{},
      dust_filters: %{},
      expansion_slots: %{},
      fan_options: %{},
      included_psu: "some updated included_psu",
      io: %{},
      manufacturer: "some updated manufacturer",
      model: "some updated model",
      model_number: "some updated model_number",
      motherboard_support: [],
      name: "some updated name",
      psu_mount_location: "some updated psu_mount_location",
      psu_shroud: "some updated psu_shroud",
      psu_support: [],
      radiator_support: %{},
      release: ~D[2011-05-18],
      type: "some updated type",
      weight: "456.7",
      windows: %{}
    }
    @invalid_attrs %{
      clearance: nil,
      color: nil,
      dimensions: nil,
      dust_filters: nil,
      expansion_slots: nil,
      fan_options: nil,
      included_psu: nil,
      io: nil,
      manufacturer: nil,
      model: nil,
      model_number: nil,
      motherboard_support: nil,
      name: nil,
      psu_mount_location: nil,
      psu_shroud: nil,
      psu_support: nil,
      radiator_support: nil,
      release: nil,
      type: nil,
      weight: nil,
      windows: nil
    }

    def case_fixture(attrs \\ %{}) do
      {:ok, case} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_case()

      case
    end

    test "list_cases/0 returns all cases" do
      case = case_fixture()
      assert Parts.list_cases() == [case]
    end

    test "get_case!/1 returns the case with given id" do
      case = case_fixture()
      assert Parts.get_case!(case.id) == case
    end

    test "create_case/1 with valid data creates a case" do
      assert {:ok, %Case{} = case} = Parts.create_case(@valid_attrs)
      assert case.clearance == %{}
      assert case.color == "some color"
      assert case.dimensions == %{}
      assert case.dust_filters == %{}
      assert case.expansion_slots == %{}
      assert case.fan_options == %{}
      assert case.included_psu == "some included_psu"
      assert case.io == %{}
      assert case.manufacturer == "some manufacturer"
      assert case.model == "some model"
      assert case.model_number == "some model_number"
      assert case.motherboard_support == []
      assert case.name == "some name"
      assert case.psu_mount_location == "some psu_mount_location"
      assert case.psu_shroud == "some psu_shroud"
      assert case.psu_support == []
      assert case.radiator_support == %{}
      assert case.release == ~D[2010-04-17]
      assert case.type == "some type"
      assert case.weight == Decimal.new("120.5")
      assert case.windows == %{}
    end

    test "create_case/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_case(@invalid_attrs)
    end

    test "update_case/2 with valid data updates the case" do
      case = case_fixture()
      assert {:ok, %Case{} = case} = Parts.update_case(case, @update_attrs)
      assert case.clearance == %{}
      assert case.color == "some updated color"
      assert case.dimensions == %{}
      assert case.dust_filters == %{}
      assert case.expansion_slots == %{}
      assert case.fan_options == %{}
      assert case.included_psu == "some updated included_psu"
      assert case.io == %{}
      assert case.manufacturer == "some updated manufacturer"
      assert case.model == "some updated model"
      assert case.model_number == "some updated model_number"
      assert case.motherboard_support == []
      assert case.name == "some updated name"
      assert case.psu_mount_location == "some updated psu_mount_location"
      assert case.psu_shroud == "some updated psu_shroud"
      assert case.psu_support == []
      assert case.radiator_support == %{}
      assert case.release == ~D[2011-05-18]
      assert case.type == "some updated type"
      assert case.weight == Decimal.new("456.7")
      assert case.windows == %{}
    end

    test "update_case/2 with invalid data returns error changeset" do
      case = case_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_case(case, @invalid_attrs)
      assert case == Parts.get_case!(case.id)
    end

    test "delete_case/1 deletes the case" do
      case = case_fixture()
      assert {:ok, %Case{}} = Parts.delete_case(case)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_case!(case.id) end
    end

    test "change_case/1 returns a case changeset" do
      case = case_fixture()
      assert %Ecto.Changeset{} = Parts.change_case(case)
    end
  end

  describe "cpu_coolers" do
    alias Pcpb.Parts.CPUCooler

    @valid_attrs %{
      amd_socket_support: [],
      bearing_type: "some bearing_type",
      color: "some color",
      dimensions: %{},
      fan_cfm: "some fan_cfm",
      fan_dimensions: "some fan_dimensions",
      fan_size: 42,
      fans: 42,
      intel_socket_support: [],
      led: "some led",
      manufacturer: "some manufacturer",
      model: "some model",
      model_number: "some model_number",
      name: "some name",
      noise_level: "some noise_level",
      release: ~D[2010-04-17],
      rgb: "some rgb",
      rpm: "some rpm",
      series: "some series",
      type: "some type",
      watercool: %{}
    }
    @update_attrs %{
      amd_socket_support: [],
      bearing_type: "some updated bearing_type",
      color: "some updated color",
      dimensions: %{},
      fan_cfm: "some updated fan_cfm",
      fan_dimensions: "some updated fan_dimensions",
      fan_size: 43,
      fans: 43,
      intel_socket_support: [],
      led: "some updated led",
      manufacturer: "some updated manufacturer",
      model: "some updated model",
      model_number: "some updated model_number",
      name: "some updated name",
      noise_level: "some updated noise_level",
      release: ~D[2011-05-18],
      rgb: "some updated rgb",
      rpm: "some updated rpm",
      series: "some updated series",
      type: "some updated type",
      watercool: %{}
    }
    @invalid_attrs %{
      amd_socket_support: nil,
      bearing_type: nil,
      color: nil,
      dimensions: nil,
      fan_cfm: nil,
      fan_dimensions: nil,
      fan_size: nil,
      fans: nil,
      intel_socket_support: nil,
      led: nil,
      manufacturer: nil,
      model: nil,
      model_number: nil,
      name: nil,
      noise_level: nil,
      release: nil,
      rgb: nil,
      rpm: nil,
      series: nil,
      type: nil,
      watercool: nil
    }

    def cpu_cooler_fixture(attrs \\ %{}) do
      {:ok, cpu_cooler} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_cpu_cooler()

      cpu_cooler
    end

    test "list_cpu_coolers/0 returns all cpu_coolers" do
      cpu_cooler = cpu_cooler_fixture()
      assert Parts.list_cpu_coolers() == [cpu_cooler]
    end

    test "get_cpu_cooler!/1 returns the cpu_cooler with given id" do
      cpu_cooler = cpu_cooler_fixture()
      assert Parts.get_cpu_cooler!(cpu_cooler.id) == cpu_cooler
    end

    test "create_cpu_cooler/1 with valid data creates a cpu_cooler" do
      assert {:ok, %CPUCooler{} = cpu_cooler} = Parts.create_cpu_cooler(@valid_attrs)
      assert cpu_cooler.amd_socket_support == []
      assert cpu_cooler.bearing_type == "some bearing_type"
      assert cpu_cooler.color == "some color"
      assert cpu_cooler.dimensions == %{}
      assert cpu_cooler.fan_cfm == "some fan_cfm"
      assert cpu_cooler.fan_dimensions == "some fan_dimensions"
      assert cpu_cooler.fan_size == 42
      assert cpu_cooler.fans == 42
      assert cpu_cooler.intel_socket_support == []
      assert cpu_cooler.led == "some led"
      assert cpu_cooler.manufacturer == "some manufacturer"
      assert cpu_cooler.model == "some model"
      assert cpu_cooler.model_number == "some model_number"
      assert cpu_cooler.name == "some name"
      assert cpu_cooler.noise_level == "some noise_level"
      assert cpu_cooler.release == ~D[2010-04-17]
      assert cpu_cooler.rgb == "some rgb"
      assert cpu_cooler.rpm == "some rpm"
      assert cpu_cooler.series == "some series"
      assert cpu_cooler.type == "some type"
      assert cpu_cooler.watercool == %{}
    end

    test "create_cpu_cooler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_cpu_cooler(@invalid_attrs)
    end

    test "update_cpu_cooler/2 with valid data updates the cpu_cooler" do
      cpu_cooler = cpu_cooler_fixture()
      assert {:ok, %CPUCooler{} = cpu_cooler} = Parts.update_cpu_cooler(cpu_cooler, @update_attrs)
      assert cpu_cooler.amd_socket_support == []
      assert cpu_cooler.bearing_type == "some updated bearing_type"
      assert cpu_cooler.color == "some updated color"
      assert cpu_cooler.dimensions == %{}
      assert cpu_cooler.fan_cfm == "some updated fan_cfm"
      assert cpu_cooler.fan_dimensions == "some updated fan_dimensions"
      assert cpu_cooler.fan_size == 43
      assert cpu_cooler.fans == 43
      assert cpu_cooler.intel_socket_support == []
      assert cpu_cooler.led == "some updated led"
      assert cpu_cooler.manufacturer == "some updated manufacturer"
      assert cpu_cooler.model == "some updated model"
      assert cpu_cooler.model_number == "some updated model_number"
      assert cpu_cooler.name == "some updated name"
      assert cpu_cooler.noise_level == "some updated noise_level"
      assert cpu_cooler.release == ~D[2011-05-18]
      assert cpu_cooler.rgb == "some updated rgb"
      assert cpu_cooler.rpm == "some updated rpm"
      assert cpu_cooler.series == "some updated series"
      assert cpu_cooler.type == "some updated type"
      assert cpu_cooler.watercool == %{}
    end

    test "update_cpu_cooler/2 with invalid data returns error changeset" do
      cpu_cooler = cpu_cooler_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_cpu_cooler(cpu_cooler, @invalid_attrs)
      assert cpu_cooler == Parts.get_cpu_cooler!(cpu_cooler.id)
    end

    test "delete_cpu_cooler/1 deletes the cpu_cooler" do
      cpu_cooler = cpu_cooler_fixture()
      assert {:ok, %CPUCooler{}} = Parts.delete_cpu_cooler(cpu_cooler)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_cpu_cooler!(cpu_cooler.id) end
    end

    test "change_cpu_cooler/1 returns a cpu_cooler changeset" do
      cpu_cooler = cpu_cooler_fixture()
      assert %Ecto.Changeset{} = Parts.change_cpu_cooler(cpu_cooler)
    end
  end

  describe "cpu_coolers" do
    alias Pcpb.Parts.CPUCooler

    @valid_attrs %{bearing_type: "some bearing_type", color: "some color", dimensions: %{}, fan_cfm: "some fan_cfm", fan_size: 42, fans: "some fans", led: "some led", manufacturer: "some manufacturer", model: "some model", model_number: "some model_number", name: "some name", noise_level: "some noise_level", radiator_support: "some radiator_support", release: ~D[2010-04-17], rpm: "some rpm", series: "some series", socket_support: [], type: "some type"}
    @update_attrs %{bearing_type: "some updated bearing_type", color: "some updated color", dimensions: %{}, fan_cfm: "some updated fan_cfm", fan_size: 43, fans: "some updated fans", led: "some updated led", manufacturer: "some updated manufacturer", model: "some updated model", model_number: "some updated model_number", name: "some updated name", noise_level: "some updated noise_level", radiator_support: "some updated radiator_support", release: ~D[2011-05-18], rpm: "some updated rpm", series: "some updated series", socket_support: [], type: "some updated type"}
    @invalid_attrs %{bearing_type: nil, color: nil, dimensions: nil, fan_cfm: nil, fan_size: nil, fans: nil, led: nil, manufacturer: nil, model: nil, model_number: nil, name: nil, noise_level: nil, radiator_support: nil, release: nil, rpm: nil, series: nil, socket_support: nil, type: nil}

    def cpu_cooler_fixture(attrs \\ %{}) do
      {:ok, cpu_cooler} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_cpu_cooler()

      cpu_cooler
    end

    test "list_cpu_coolers/0 returns all cpu_coolers" do
      cpu_cooler = cpu_cooler_fixture()
      assert Parts.list_cpu_coolers() == [cpu_cooler]
    end

    test "get_cpu_cooler!/1 returns the cpu_cooler with given id" do
      cpu_cooler = cpu_cooler_fixture()
      assert Parts.get_cpu_cooler!(cpu_cooler.id) == cpu_cooler
    end

    test "create_cpu_cooler/1 with valid data creates a cpu_cooler" do
      assert {:ok, %CPUCooler{} = cpu_cooler} = Parts.create_cpu_cooler(@valid_attrs)
      assert cpu_cooler.bearing_type == "some bearing_type"
      assert cpu_cooler.color == "some color"
      assert cpu_cooler.dimensions == %{}
      assert cpu_cooler.fan_cfm == "some fan_cfm"
      assert cpu_cooler.fan_size == 42
      assert cpu_cooler.fans == "some fans"
      assert cpu_cooler.led == "some led"
      assert cpu_cooler.manufacturer == "some manufacturer"
      assert cpu_cooler.model == "some model"
      assert cpu_cooler.model_number == "some model_number"
      assert cpu_cooler.name == "some name"
      assert cpu_cooler.noise_level == "some noise_level"
      assert cpu_cooler.radiator_support == "some radiator_support"
      assert cpu_cooler.release == ~D[2010-04-17]
      assert cpu_cooler.rpm == "some rpm"
      assert cpu_cooler.series == "some series"
      assert cpu_cooler.socket_support == []
      assert cpu_cooler.type == "some type"
    end

    test "create_cpu_cooler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_cpu_cooler(@invalid_attrs)
    end

    test "update_cpu_cooler/2 with valid data updates the cpu_cooler" do
      cpu_cooler = cpu_cooler_fixture()
      assert {:ok, %CPUCooler{} = cpu_cooler} = Parts.update_cpu_cooler(cpu_cooler, @update_attrs)
      assert cpu_cooler.bearing_type == "some updated bearing_type"
      assert cpu_cooler.color == "some updated color"
      assert cpu_cooler.dimensions == %{}
      assert cpu_cooler.fan_cfm == "some updated fan_cfm"
      assert cpu_cooler.fan_size == 43
      assert cpu_cooler.fans == "some updated fans"
      assert cpu_cooler.led == "some updated led"
      assert cpu_cooler.manufacturer == "some updated manufacturer"
      assert cpu_cooler.model == "some updated model"
      assert cpu_cooler.model_number == "some updated model_number"
      assert cpu_cooler.name == "some updated name"
      assert cpu_cooler.noise_level == "some updated noise_level"
      assert cpu_cooler.radiator_support == "some updated radiator_support"
      assert cpu_cooler.release == ~D[2011-05-18]
      assert cpu_cooler.rpm == "some updated rpm"
      assert cpu_cooler.series == "some updated series"
      assert cpu_cooler.socket_support == []
      assert cpu_cooler.type == "some updated type"
    end

    test "update_cpu_cooler/2 with invalid data returns error changeset" do
      cpu_cooler = cpu_cooler_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_cpu_cooler(cpu_cooler, @invalid_attrs)
      assert cpu_cooler == Parts.get_cpu_cooler!(cpu_cooler.id)
    end

    test "delete_cpu_cooler/1 deletes the cpu_cooler" do
      cpu_cooler = cpu_cooler_fixture()
      assert {:ok, %CPUCooler{}} = Parts.delete_cpu_cooler(cpu_cooler)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_cpu_cooler!(cpu_cooler.id) end
    end

    test "change_cpu_cooler/1 returns a cpu_cooler changeset" do
      cpu_cooler = cpu_cooler_fixture()
      assert %Ecto.Changeset{} = Parts.change_cpu_cooler(cpu_cooler)
    end
  end
end
