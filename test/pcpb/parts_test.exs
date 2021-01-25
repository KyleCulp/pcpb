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

  describe "gpus" do
    alias Pcpb.Parts.GPU

    @valid_attrs %{name: "some name", memory_type: "some memory_type", dimensions: %{}, backplate: "some backplate", interface: "some interface", release: ~D[2010-04-17], opengl: "some opengl", model_number: "some model_number", hdcp: "some hdcp", cooler: "some cooler", power_connector: "some power_connector", crossfire_support: "some crossfire_support", series: "some series", chipset: "some chipset", max_resolution: "some max_resolution", rgb: "some rgb", slot_width: "some slot_width", model: "some model", stream_processors: 42, directx: "some directx", io: %{}, max_monitors: "some max_monitors", memory: "some memory", frame_sync: "some frame_sync", core_clock: "120.5", ray_tracing: "some ray_tracing", GPU: "some GPU", memory_clock: "some memory_clock", virtuallink: "some virtuallink", boost_clock: "120.5", sli_support: "some sli_support", cuda_cores: 42, memory_interface: "some memory_interface", manufacturer: "some manufacturer"}
    @update_attrs %{name: "some updated name", memory_type: "some updated memory_type", dimensions: %{}, backplate: "some updated backplate", interface: "some updated interface", release: ~D[2011-05-18], opengl: "some updated opengl", model_number: "some updated model_number", hdcp: "some updated hdcp", cooler: "some updated cooler", power_connector: "some updated power_connector", crossfire_support: "some updated crossfire_support", series: "some updated series", chipset: "some updated chipset", max_resolution: "some updated max_resolution", rgb: "some updated rgb", slot_width: "some updated slot_width", model: "some updated model", stream_processors: 43, directx: "some updated directx", io: %{}, max_monitors: "some updated max_monitors", memory: "some updated memory", frame_sync: "some updated frame_sync", core_clock: "456.7", ray_tracing: "some updated ray_tracing", GPU: "some updated GPU", memory_clock: "some updated memory_clock", virtuallink: "some updated virtuallink", boost_clock: "456.7", sli_support: "some updated sli_support", cuda_cores: 43, memory_interface: "some updated memory_interface", manufacturer: "some updated manufacturer"}
    @invalid_attrs %{name: nil, memory_type: nil, dimensions: nil, backplate: nil, interface: nil, release: nil, opengl: nil, model_number: nil, hdcp: nil, cooler: nil, power_connector: nil, crossfire_support: nil, series: nil, chipset: nil, max_resolution: nil, rgb: nil, slot_width: nil, model: nil, stream_processors: nil, directx: nil, io: nil, max_monitors: nil, memory: nil, frame_sync: nil, core_clock: nil, ray_tracing: nil, GPU: nil, memory_clock: nil, virtuallink: nil, boost_clock: nil, sli_support: nil, cuda_cores: nil, memory_interface: nil, manufacturer: nil}

    def gpu_fixture(attrs \\ %{}) do
      {:ok, gpu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_gpu()

      gpu
    end

    test "list_gpus/0 returns all gpus" do
      gpu = gpu_fixture()
      assert Parts.list_gpus() == [gpu]
    end

    test "get_gpu!/1 returns the gpu with given id" do
      gpu = gpu_fixture()
      assert Parts.get_gpu!(gpu.id) == gpu
    end

    test "create_gpu/1 with valid data creates a gpu" do
      assert {:ok, %GPU{} = gpu} = Parts.create_gpu(@valid_attrs)
      assert gpu.manufacturer == "some manufacturer"
      assert gpu.memory_interface == "some memory_interface"
      assert gpu.cuda_cores == 42
      assert gpu.sli_support == "some sli_support"
      assert gpu.boost_clock == Decimal.new("120.5")
      assert gpu.virtuallink == "some virtuallink"
      assert gpu.memory_clock == "some memory_clock"
      assert gpu.GPU == "some GPU"
      assert gpu.ray_tracing == "some ray_tracing"
      assert gpu.core_clock == Decimal.new("120.5")
      assert gpu.frame_sync == "some frame_sync"
      assert gpu.memory == "some memory"
      assert gpu.max_monitors == "some max_monitors"
      assert gpu.io == %{}
      assert gpu.directx == "some directx"
      assert gpu.stream_processors == 42
      assert gpu.model == "some model"
      assert gpu.slot_width == "some slot_width"
      assert gpu.rgb == "some rgb"
      assert gpu.max_resolution == "some max_resolution"
      assert gpu.chipset == "some chipset"
      assert gpu.series == "some series"
      assert gpu.crossfire_support == "some crossfire_support"
      assert gpu.power_connector == "some power_connector"
      assert gpu.cooler == "some cooler"
      assert gpu.hdcp == "some hdcp"
      assert gpu.model_number == "some model_number"
      assert gpu.opengl == "some opengl"
      assert gpu.release == ~D[2010-04-17]
      assert gpu.interface == "some interface"
      assert gpu.backplate == "some backplate"
      assert gpu.dimensions == %{}
      assert gpu.memory_type == "some memory_type"
      assert gpu.name == "some name"
    end

    test "create_gpu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_gpu(@invalid_attrs)
    end

    test "update_gpu/2 with valid data updates the gpu" do
      gpu = gpu_fixture()
      assert {:ok, %GPU{} = gpu} = Parts.update_gpu(gpu, @update_attrs)
      assert gpu.manufacturer == "some updated manufacturer"
      assert gpu.memory_interface == "some updated memory_interface"
      assert gpu.cuda_cores == 43
      assert gpu.sli_support == "some updated sli_support"
      assert gpu.boost_clock == Decimal.new("456.7")
      assert gpu.virtuallink == "some updated virtuallink"
      assert gpu.memory_clock == "some updated memory_clock"
      assert gpu.GPU == "some updated GPU"
      assert gpu.ray_tracing == "some updated ray_tracing"
      assert gpu.core_clock == Decimal.new("456.7")
      assert gpu.frame_sync == "some updated frame_sync"
      assert gpu.memory == "some updated memory"
      assert gpu.max_monitors == "some updated max_monitors"
      assert gpu.io == %{}
      assert gpu.directx == "some updated directx"
      assert gpu.stream_processors == 43
      assert gpu.model == "some updated model"
      assert gpu.slot_width == "some updated slot_width"
      assert gpu.rgb == "some updated rgb"
      assert gpu.max_resolution == "some updated max_resolution"
      assert gpu.chipset == "some updated chipset"
      assert gpu.series == "some updated series"
      assert gpu.crossfire_support == "some updated crossfire_support"
      assert gpu.power_connector == "some updated power_connector"
      assert gpu.cooler == "some updated cooler"
      assert gpu.hdcp == "some updated hdcp"
      assert gpu.model_number == "some updated model_number"
      assert gpu.opengl == "some updated opengl"
      assert gpu.release == ~D[2011-05-18]
      assert gpu.interface == "some updated interface"
      assert gpu.backplate == "some updated backplate"
      assert gpu.dimensions == %{}
      assert gpu.memory_type == "some updated memory_type"
      assert gpu.name == "some updated name"
    end

    test "update_gpu/2 with invalid data returns error changeset" do
      gpu = gpu_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_gpu(gpu, @invalid_attrs)
      assert gpu == Parts.get_gpu!(gpu.id)
    end

    test "delete_gpu/1 deletes the gpu" do
      gpu = gpu_fixture()
      assert {:ok, %GPU{}} = Parts.delete_gpu(gpu)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_gpu!(gpu.id) end
    end

    test "change_gpu/1 returns a gpu changeset" do
      gpu = gpu_fixture()
      assert %Ecto.Changeset{} = Parts.change_gpu(gpu)
    end
  end

  describe "memorys" do
    alias Pcpb.Parts.Memory

    @valid_attrs %{cas_latency: 42, chipset: "some chipset", color: "some color", ecc: "some ecc", ecc_rank: "some ecc_rank", heatsink: "some heatsink", launch: ~D[2010-04-17], led: "some led", manufacturer: "some manufacturer", model: "some model", model_number: "some model_number", modules: "some modules", name: "some name", series: "some series", speed: "some speed", timing: "some timing", type: "some type", voltage: "some voltage"}
    @update_attrs %{cas_latency: 43, chipset: "some updated chipset", color: "some updated color", ecc: "some updated ecc", ecc_rank: "some updated ecc_rank", heatsink: "some updated heatsink", launch: ~D[2011-05-18], led: "some updated led", manufacturer: "some updated manufacturer", model: "some updated model", model_number: "some updated model_number", modules: "some updated modules", name: "some updated name", series: "some updated series", speed: "some updated speed", timing: "some updated timing", type: "some updated type", voltage: "some updated voltage"}
    @invalid_attrs %{cas_latency: nil, chipset: nil, color: nil, ecc: nil, ecc_rank: nil, heatsink: nil, launch: nil, led: nil, manufacturer: nil, model: nil, model_number: nil, modules: nil, name: nil, series: nil, speed: nil, timing: nil, type: nil, voltage: nil}

    def memory_fixture(attrs \\ %{}) do
      {:ok, memory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_memory()

      memory
    end

    test "list_memorys/0 returns all memorys" do
      memory = memory_fixture()
      assert Parts.list_memorys() == [memory]
    end

    test "get_memory!/1 returns the memory with given id" do
      memory = memory_fixture()
      assert Parts.get_memory!(memory.id) == memory
    end

    test "create_memory/1 with valid data creates a memory" do
      assert {:ok, %Memory{} = memory} = Parts.create_memory(@valid_attrs)
      assert memory.cas_latency == 42
      assert memory.chipset == "some chipset"
      assert memory.color == "some color"
      assert memory.ecc == "some ecc"
      assert memory.ecc_rank == "some ecc_rank"
      assert memory.heatsink == "some heatsink"
      assert memory.launch == ~D[2010-04-17]
      assert memory.led == "some led"
      assert memory.manufacturer == "some manufacturer"
      assert memory.model == "some model"
      assert memory.model_number == "some model_number"
      assert memory.modules == "some modules"
      assert memory.name == "some name"
      assert memory.series == "some series"
      assert memory.speed == "some speed"
      assert memory.timing == "some timing"
      assert memory.type == "some type"
      assert memory.voltage == "some voltage"
    end

    test "create_memory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_memory(@invalid_attrs)
    end

    test "update_memory/2 with valid data updates the memory" do
      memory = memory_fixture()
      assert {:ok, %Memory{} = memory} = Parts.update_memory(memory, @update_attrs)
      assert memory.cas_latency == 43
      assert memory.chipset == "some updated chipset"
      assert memory.color == "some updated color"
      assert memory.ecc == "some updated ecc"
      assert memory.ecc_rank == "some updated ecc_rank"
      assert memory.heatsink == "some updated heatsink"
      assert memory.launch == ~D[2011-05-18]
      assert memory.led == "some updated led"
      assert memory.manufacturer == "some updated manufacturer"
      assert memory.model == "some updated model"
      assert memory.model_number == "some updated model_number"
      assert memory.modules == "some updated modules"
      assert memory.name == "some updated name"
      assert memory.series == "some updated series"
      assert memory.speed == "some updated speed"
      assert memory.timing == "some updated timing"
      assert memory.type == "some updated type"
      assert memory.voltage == "some updated voltage"
    end

    test "update_memory/2 with invalid data returns error changeset" do
      memory = memory_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_memory(memory, @invalid_attrs)
      assert memory == Parts.get_memory!(memory.id)
    end

    test "delete_memory/1 deletes the memory" do
      memory = memory_fixture()
      assert {:ok, %Memory{}} = Parts.delete_memory(memory)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_memory!(memory.id) end
    end

    test "change_memory/1 returns a memory changeset" do
      memory = memory_fixture()
      assert %Ecto.Changeset{} = Parts.change_memory(memory)
    end
  end

  describe "psus" do
    alias Pcpb.Parts.PSU

    @valid_attrs %{"12v_rails": "some 12v_rails", MTBF: "some MTBF", cable_type: "some cable_type", color: "some color", dimensions: %{}, efficiency: "some efficiency", fan_bearing: "some fan_bearing", fan_size: "some fan_size", fanless: "some fanless", form_factor: "some form_factor", input_current: "some input_current", input_voltage: "some input_voltage", led: "some led", main_connector: "some main_connector", modular: "some modular", pci_express_connector: "some pci_express_connector", rating: "some rating", rgb: "some rgb", sata_connectors: "some sata_connectors", series: "some series", type: "some type", wattage: 42, weight: 42}
    @update_attrs %{"12v_rails": "some updated 12v_rails", MTBF: "some updated MTBF", cable_type: "some updated cable_type", color: "some updated color", dimensions: %{}, efficiency: "some updated efficiency", fan_bearing: "some updated fan_bearing", fan_size: "some updated fan_size", fanless: "some updated fanless", form_factor: "some updated form_factor", input_current: "some updated input_current", input_voltage: "some updated input_voltage", led: "some updated led", main_connector: "some updated main_connector", modular: "some updated modular", pci_express_connector: "some updated pci_express_connector", rating: "some updated rating", rgb: "some updated rgb", sata_connectors: "some updated sata_connectors", series: "some updated series", type: "some updated type", wattage: 43, weight: 43}
    @invalid_attrs %{"12v_rails": nil, MTBF: nil, cable_type: nil, color: nil, dimensions: nil, efficiency: nil, fan_bearing: nil, fan_size: nil, fanless: nil, form_factor: nil, input_current: nil, input_voltage: nil, led: nil, main_connector: nil, modular: nil, pci_express_connector: nil, rating: nil, rgb: nil, sata_connectors: nil, series: nil, type: nil, wattage: nil, weight: nil}

    def psu_fixture(attrs \\ %{}) do
      {:ok, psu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_psu()

      psu
    end

    test "list_psus/0 returns all psus" do
      psu = psu_fixture()
      assert Parts.list_psus() == [psu]
    end

    test "get_psu!/1 returns the psu with given id" do
      psu = psu_fixture()
      assert Parts.get_psu!(psu.id) == psu
    end

    test "create_psu/1 with valid data creates a psu" do
      assert {:ok, %PSU{} = psu} = Parts.create_psu(@valid_attrs)
      assert psu.12v_rails == "some 12v_rails"
      assert psu.MTBF == "some MTBF"
      assert psu.cable_type == "some cable_type"
      assert psu.color == "some color"
      assert psu.dimensions == %{}
      assert psu.efficiency == "some efficiency"
      assert psu.fan_bearing == "some fan_bearing"
      assert psu.fan_size == "some fan_size"
      assert psu.fanless == "some fanless"
      assert psu.form_factor == "some form_factor"
      assert psu.input_current == "some input_current"
      assert psu.input_voltage == "some input_voltage"
      assert psu.led == "some led"
      assert psu.main_connector == "some main_connector"
      assert psu.modular == "some modular"
      assert psu.pci_express_connector == "some pci_express_connector"
      assert psu.rating == "some rating"
      assert psu.rgb == "some rgb"
      assert psu.sata_connectors == "some sata_connectors"
      assert psu.series == "some series"
      assert psu.type == "some type"
      assert psu.wattage == 42
      assert psu.weight == 42
    end

    test "create_psu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_psu(@invalid_attrs)
    end

    test "update_psu/2 with valid data updates the psu" do
      psu = psu_fixture()
      assert {:ok, %PSU{} = psu} = Parts.update_psu(psu, @update_attrs)
      assert psu.12v_rails == "some updated 12v_rails"
      assert psu.MTBF == "some updated MTBF"
      assert psu.cable_type == "some updated cable_type"
      assert psu.color == "some updated color"
      assert psu.dimensions == %{}
      assert psu.efficiency == "some updated efficiency"
      assert psu.fan_bearing == "some updated fan_bearing"
      assert psu.fan_size == "some updated fan_size"
      assert psu.fanless == "some updated fanless"
      assert psu.form_factor == "some updated form_factor"
      assert psu.input_current == "some updated input_current"
      assert psu.input_voltage == "some updated input_voltage"
      assert psu.led == "some updated led"
      assert psu.main_connector == "some updated main_connector"
      assert psu.modular == "some updated modular"
      assert psu.pci_express_connector == "some updated pci_express_connector"
      assert psu.rating == "some updated rating"
      assert psu.rgb == "some updated rgb"
      assert psu.sata_connectors == "some updated sata_connectors"
      assert psu.series == "some updated series"
      assert psu.type == "some updated type"
      assert psu.wattage == 43
      assert psu.weight == 43
    end

    test "update_psu/2 with invalid data returns error changeset" do
      psu = psu_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_psu(psu, @invalid_attrs)
      assert psu == Parts.get_psu!(psu.id)
    end

    test "delete_psu/1 deletes the psu" do
      psu = psu_fixture()
      assert {:ok, %PSU{}} = Parts.delete_psu(psu)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_psu!(psu.id) end
    end

    test "change_psu/1 returns a psu changeset" do
      psu = psu_fixture()
      assert %Ecto.Changeset{} = Parts.change_psu(psu)
    end
  end

  describe "parts" do
    alias Pcpb.Parts.Part

    @valid_attrs %{part_id: "some part_id", part_type: "some part_type"}
    @update_attrs %{part_id: "some updated part_id", part_type: "some updated part_type"}
    @invalid_attrs %{part_id: nil, part_type: nil}

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
      assert part.part_id == "some part_id"
      assert part.part_type == "some part_type"
    end

    test "create_part/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_part(@invalid_attrs)
    end

    test "update_part/2 with valid data updates the part" do
      part = part_fixture()
      assert {:ok, %Part{} = part} = Parts.update_part(part, @update_attrs)
      assert part.part_id == "some updated part_id"
      assert part.part_type == "some updated part_type"
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

  describe "metadatas" do
    alias Pcpb.Parts.Metadata

    @valid_attrs %{edits: []}
    @update_attrs %{edits: []}
    @invalid_attrs %{edits: nil}

    def metadata_fixture(attrs \\ %{}) do
      {:ok, metadata} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_metadata()

      metadata
    end

    test "list_metadatas/0 returns all metadatas" do
      metadata = metadata_fixture()
      assert Parts.list_metadatas() == [metadata]
    end

    test "get_metadata!/1 returns the metadata with given id" do
      metadata = metadata_fixture()
      assert Parts.get_metadata!(metadata.id) == metadata
    end

    test "create_metadata/1 with valid data creates a metadata" do
      assert {:ok, %Metadata{} = metadata} = Parts.create_metadata(@valid_attrs)
      assert metadata.edits == []
    end

    test "create_metadata/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_metadata(@invalid_attrs)
    end

    test "update_metadata/2 with valid data updates the metadata" do
      metadata = metadata_fixture()
      assert {:ok, %Metadata{} = metadata} = Parts.update_metadata(metadata, @update_attrs)
      assert metadata.edits == []
    end

    test "update_metadata/2 with invalid data returns error changeset" do
      metadata = metadata_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_metadata(metadata, @invalid_attrs)
      assert metadata == Parts.get_metadata!(metadata.id)
    end

    test "delete_metadata/1 deletes the metadata" do
      metadata = metadata_fixture()
      assert {:ok, %Metadata{}} = Parts.delete_metadata(metadata)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_metadata!(metadata.id) end
    end

    test "change_metadata/1 returns a metadata changeset" do
      metadata = metadata_fixture()
      assert %Ecto.Changeset{} = Parts.change_metadata(metadata)
    end
  end
end
