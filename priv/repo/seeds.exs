# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pcpb.Repo.insert!(%Pcpb.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Pcpb.Repo
alias Pcpb.Users.User
alias Pcpb.Parts.{CPU, Case, CPUCooler, GPU, Memory, PSU}
import Pcpb.Parts




Pcpb.Users.create_user(%{
  email: "admin@pcpb.app",
  password: "12345678",
  password_confirmation: "12345678",
  admin: true,
  username: "kryllis"
})

create_cpu(%{
  id: generate_part_id(:cpu),
  name: "Core i9-10850K",
  manufacturer: "Intel",
  model: "Intel Core i9-10850K Comet Lake 10-Core 3.6 GHz",
  launch: ~D[2020-04-18],
  model_number: "BX8070110850K",
  family: "Comet Lake",
  series: "Core i9 10th Gen",
  socket: "LGA 1200",
  unlocked: true,
  pci_version: "PCIe 3.0",
  pci_lanes: 16,
  memory_type: "DDR4",
  cache: "20 MB Intel® Smart Cache",
  cache_map: %{
    l1instruction: "320 kB",
    l1data: "320 kB",
    l2: "2560 kB",
    l3: "20 MB"
  },
  core_count: 10,
  core_clock: 3.6,
  boost_clock: 5.2,
  ecc_support: "false",
  integrated_graphics: "Intel® UHD Graphics 630",
  lithography: "14 nm",
  max_memory: 128,
  memory_channels: 2,
  smt: "true",
  stock_cooler: "false",
  tdp: 125
})


create_cpu(%{
  id: generate_part_id(:cpu),
  name: "Ryzen 9 5900X",
  manufacturer: "AMD",
  model: "AMD Ryzen 9 5900X 12-Core 3.7 GHz",
  launch: ~D[2020-11-05],
  model_number: "100-100000061WOF",
  family: "AMD Ryzen Processors",
  series: "Ryzen 9 5000 Series",
  socket: "LGA 1200",
  unlocked: true,
  pci_version: "PCIe 4.0",
  pci_lanes: 20,
  memory_type: "DDR4",
  # cache: "",
  cache_map: %{
    l1instruction: "384 kB",
    l1data: "384 kB",
    l2: "6 MB",
    l3: "64 MB"
  },
  core_count: 12,
  core_clock: 3.7,
  boost_clock: 4.8,
  ecc_support: "true",
  integrated_graphics: "false",
  lithography: "7 nm",
  max_memory: 128,
  memory_channels: 2,
  smt: "true",
  stock_cooler: "false",
  tdp: 125
})


create_case(%{
  id: generate_part_id(:case),
  name: "MasterBox Q300L",
  manufacturer: "Cooler Master",
  model: "Cooler Master MasterBox Q300L MicroATX Mini Tower Case",
  model_number: "MCB-Q300L-KANN-S00",
  launch: ~D[2020-04-18],
  color: "black",
  material: "Steel / Black",
  type: "Micro ATX Tower",
  motherboard_support: ["Micro_ATX", "Mini_ITX"],
  psu_support: ["ATX"],
  psu_mount_location: "bottom",
  psu_shroud: "false",
  included_psu: "false",
  weight: 3.7,
  clearance: %{
    gpu_length: 360,
    cpu_cooler_height: 157,
    psu_length: 160
  },
  dimensions: %{
    length: 387.35,
    width: 230.12,
    height: 381
  },
  dust_filters: %{
    front: false,
    back: false,
    top: false,
    bottom: true,
    psu: true
  },
  fan_options: %{
    front: ["2 x 120mm", "2 x 140mm fan"],
    back: ["1 x 120mm fan"],
    top: [" 2 x 120mm fan"],
    bottom: ["1 x 120mm fan"]
  },
  radiator_support: %{
    front: "240mm",
    back: "120mm"
    # top: ,
    # bottom: ,
  },
  expansion_slots: 4,
  fiveonefourthbays: 2,
  threeonehalfbays: 1,
  side_window: "Acrylic",
  io: ["2 x USB 3.0", "Audio"]
})


create_case(%{
  id: generate_part_id(:case),
  name: "Corsair other case haha",
  manufacturer: "Corsair",
  model: "Cooler Master MasterBox Q300L MicroATX Mini Tower Case",
  model_number: "MCB-Q300L-KANN-S00",
  launch: ~D[2020-04-18],
  color: "black",
  material: "Steel / Black",
  type: "Micro ATX Tower",
  motherboard_support: ["EATX", "ATX", "Micro_ATX", "Mini_ITX"],
  psu_support: ["SFX"],
  psu_mount_location: "bottom",
  psu_shroud: "false",
  included_psu: "false",
  weight: 3.7,
  clearance: %{
    gpu_length: 360,
    cpu_cooler_height: 157,
    psu_length: 160
  },
  dimensions: %{
    length: 387.35,
    width: 230.12,
    height: 381
  },
  dust_filters: %{
    front: false,
    back: false,
    top: false,
    bottom: true,
    psu: true
  },
  fan_options: %{
    front: ["2 x 120mm", "2 x 140mm fan"],
    back: ["1 x 120mm fan"],
    top: [" 2 x 120mm fan"],
    bottom: ["1 x 120mm fan"]
  },
  radiator_support: %{
    front: "240mm",
    back: "120mm"
    # top: ,
    # bottom: ,
  },
  expansion_slots: 4,
  fiveonefourthbays: 2,
  threeonehalfbays: 1,
  side_window: "Acrylic",
  io: ["2 x USB 3.0", "Audio"]
})


# %Case{}
# |> Case.changeset(%{
#   name: "",
#   manufacturer: "",
#   model: "",
#   model_number: "",
#   launch: ~D[2020-04-18],
#   color: "",
#   type: "",
#   motherboard_support: [ATX, Micro_ATX, Mini_ITX],
#   psu_support: ["ATX"]
#   psu_mount_location: "",
#   psu_shroud: "",
#   included_psu: "",
#   weight: ,
#   clearance: %{
#     gpu_length: ,
#     cpu_cooler_height: ,
#     psu_length:
#   },
#   dimensions: %{
#     length: ,
#     width: ,
#     height:
#   },
#   dust_filters: %{
#     front: ,
#     back: ,
#     top: ,
#     bottom: ,
#     psu:
#   },
#   fan_options: %{
#     front: ,
#     back: ,
#     top: ,
#     bottom: ,
#   },
#   radiator_support: %{
#     front: ,
#     back: ,
#     top: ,
#     bottom: ,
#   },
#   expansion_slots:
#   fiveonefourthbays:
#   threeonehalfbays:
#   side_window: "",
#   io: [""]
# })
#
create_cpu_cooler(%{
  id: generate_part_id(:cpu_cooler),
  name: "Corsair H100i RGB PLATINUM",
  manufacturer: "Corsair",
  model: "Corsair H100i RGB PLATINUM 75 CFM Liquid CPU Cooler",
  model_number: "CW-9060039-WW",
  launch: ~D[2020-04-18],
  color: "Black / Silver",
  led: "fan leds / corsair icue block",
  type: "Liquid Cooling System",
  socket_support: [
    "AM2",
    "AM2+",
    "AM3+",
    "AM4",
    "FM1",
    "FM2",
    "FM2+",
    "LGA1150",
    "LGA1151",
    "LGA1155",
    "LGA1156",
    "LGA1200",
    "LGA2011",
    "LGA2011-3",
    "LGA2066"
  ],
  bearing_type: "Magnetic Levitation",
  fans: "2 x 120mm",
  fan_size: "120mm x 25mm",
  fan_cfm: "75",
  fan_rpm: "2700 rpm",
  noise_level: "37 dBA",
  radiator: "240mm",
  dimensions: %{
    length: 277.00,
    width: 120,
    height: 27
  }
})


create_cpu_cooler(%{
  id: generate_part_id(:cpu_cooler),
  name: "Hyper 212 Evo",
  manufacturer: "Cooler Master",
  model: "Cooler Master Hyper 212 Evo CPU Cooler",
  model_number: "RR-212E-20PK-R2",
  launch: ~D[2011-09-16],
  color: "Black / Silver",
  led: "fan leds / corsair icue block",
  type: "Liquid Cooling System",
  socket_support: [
    "AM2",
    "AM2+",
    "AM3+",
    "AM4",
    "FM1",
    "FM2",
    "FM2+",
    "LGA1150",
    "LGA1151",
    "LGA1155",
    "LGA1156",
    "LGA1200",
    "LGA2011",
    "LGA2011-3",
    "LGA2066"
  ],
  bearing_type: "Long Life Sleeve Bearing",
  fans: "1 x 120mm",
  fan_size: "120mm x 25mm",
  fan_cfm: "25-83 CFM",
  fan_rpm: "600 - 2000rpm",
  noise_level: "9 - 36 dBA",
  dimensions: %{
    length: 116.00,
    width: 51,
    height: 159
  }
})


create_gpu(%{
  id: generate_part_id(:gpu),
  name: "Radeon RX 570",
  manufacturer: "AMD",
  model: "MSI Radeon RX 570 DirectX 12 RX 570 ARMOR 8G OC",
  color: "Black / Red",
  model_number: "RR-212E-20PK-R2",
  launch: ~D[2017-11-01],
  series: "AMD Radeon RX 500 Series",
  chipset: "Radeon™ RX 570",
  interface: "PCI Express x16",
  directx: "DirectX 12",
  opengl: "OpenGL 4.5",
  cuda_cores: -1,
  stream_processors: 2048,
  core_clock: 1168,
  boost_clock: 1268,
  memory: "8GB",
  memory_clock: "7000 MHz",
  memory_type: "GDDR5",
  memory_interface: "256-Bit",
  sli_support: "false",
  crossfire_support: "2-Way (Bridgeless)",
  frame_sync: "FreeSync",
  slot_width: "2",
  max_resolution: "-1",
  max_monitors: 5,
  power_connector: "8-pin",
  ray_tracing: "false",
  cooler: "Double Fans",
  hdcp: "true",
  backplate: "true",
  io: ["1 x HDMI", "3 x DisplayPort", "1 x DL-DVI-D"],
  rgb: "fals",
  tdp: 150,
  weight: 0.622,
  dimensions: %{
    length: 246.00,
    width: 130,
    height: 39
  }
})


create_gpu(%{
  id: generate_part_id(:gpu),
  name: "GeForce GTX 1660 SUPER",
  manufacturer: "AMD",
  model: "MSI GeForce GTX 1660 SUPER 6 GB VENTUS XS OC",
  color: "Black / White",
  model_number: "RR-212E-20PK-R2",
  launch: ~D[2017-11-01],
  series: "GeForce GTX 1600 Series",
  chipset: "GeForce GTX 1660 SUPER",
  interface: "PCI Express 3.0 x16",
  directx: "DirectX 12",
  opengl: "OpenGL 4.5",
  cuda_cores: 1408,
  stream_processors: -1,
  core_clock: 1380,
  boost_clock: 1815,
  memory: "8GB",
  memory_clock: "7000 MHz",
  memory_type: "GDDR6",
  memory_interface: "256-Bit",
  sli_support: "false",
  crossfire_support: "2-Way (Bridgeless)",
  frame_sync: "G-Sync",
  slot_width: "2",
  max_resolution: "7680 x 4320",
  max_monitors: 4,
  power_connector: "8-pin",
  ray_tracing: "true",
  cooler: "Double Fans",
  hdcp: "2.2",
  backplate: "true",
  io: ["1 x HDMI 2.0b", "3 x DisplayPort 1.4"],
  rgb: "fals",
  tdp: 150,
  weight: 0.622,
  dimensions: %{
    length: 247,
    width: 127,
    height: 46
  }
})


create_memory(%{
  id: generate_part_id(:memory),
  name: "Corsair Vengeance RGB Pro DDR4-3200 CL16",
  manufacturer: "Corsair",
  model: "MSI GeForce GTX 1660 SUPER 6 GB VENTUS XS OC",
  model_number: "CMW32GX4M2C3200C16",
  launch: ~D[2017-11-01],
  color: "Black / LED",
  series: "VENGEANCE RGB PRO",
  type: "288-Pin DDR4 SDRAM",
  chipset: "Intel XMP 2.0",
  cas_latency: "16",
  heatsink: "Anodized Aluminum",
  module_size: "16GB",
  speed: "3200MHz",
  speeed_rating: "PC4-25600",
  timing: "16-18-18-36",
  voltage: "1.35V",
  ecc: "false",
  ecc_rank: "",
  led: "Individually Addressable",
})


# create_memory(%{
#   id: generate_part_id(:memory),
#   name: "G.SKILL Trident Z RGB DDR4-3600 CL18",
#   manufacturer: "G.SKILL",
#   model: "MSI GeForce GTX 1660 SUPER 6 GB VENTUS XS OC",
#   model_number: "F4-3600C18D-16GTZRX",
#   launch: ~D[2017-11-01],
#   color: "Black / LED",
#   series: "Trident Z RGB",
#   type: "288-Pin DDR4 SDRAM",
#   chipset: "Intel XMP 2.0",
#   heatsink: "Anodized Aluminum",
#   module_size: "8GB",
#   speed: "3200MHz",
#   speeed_rating: "PC4-28800",
#   cas_latency: "18",
#   timing: "18-22-22-42",
#   voltage: "1.35V",
#   ecc: "false",
#   ecc_rank: "",
#   led: "Individually Addressable",
# })


create_psu(%{
  id: generate_part_id(:psu),
  name: "Ion+ 660P 80 PLUS Platinum Certified 660W Full Modular Compact ATX",
  manufacturer: "Fractal Design",
  model: "Fractal Design Ion+ 660P 80 PLUS Platinum Certified 660W Full Modular Compact ATX ",
  model_number: "FD-PSU-IONP-660P-BK",
  launch: ~D[2019-08-05],
  color: "Grey / Black",
  series: "Ion+",
  type: "ATX12V 2.4 / EPS12V 2.92",
  # efficiency: "",
  wattage: 660 ,
  form_factor: "ATX",
  modular: "Full Modular",
  rating: "80 PLUS PLATINUM Certified",
  fan_bearing: "Fluid Dynamic Bearing",
  fan_size: "140mm",
  # fan_dba: "",
  main_connectors: "20+4 Pin",
  pci_express_connectors: "4 x 6+2 Pin",
  twelvevrails: 1,
  sata_connectors: 10,
  peripheral_connectors: 4,
  input_current: "10A / 5A",
  input_voltage: "100-240V",
  manufacturer_warranty: "10 years",
  MTBF: "100,000 hours",
  weight: 1.61,
  cable_type: "Braided sleeve UltraFlex wire",
  rgb: "false",
  dimensions: %{
    length: 150.00,
    width: 150,
    height: 86
  }
})

create_psu(%{
  id: generate_part_id(:psu),
  name: "Revolution D.F. 750W",
  manufacturer: "ENERMAX",
  model: "Revolution D.F. 750W 80 Plus Gold Full Modular Multi Rail",
  model_number: "ERF750AWT",
  launch: ~D[2020-12-14],
  color: "Black / White",
  series: "REVOLUTION D.F. 750W",
  type: "ATX12V / EPS12V",
  efficiency: "87-92%",
  wattage: 750,
  form_factor: "ATX",
  modular: "Full modular",
  rating: "80 PLUS GOLD Certified",
  fan_size: "135mm",
  main_connectors: "24 Pin",
  pci_express_connectors: "4 x 6+2 Pin",
  sata_connectors: 8,
  peripheral_connectors: 4,
  twelvevrails: 4,
  input_current: "10A",
  input_voltage: "100-240V",
  manufacturer_warranty: "5 years",
  MTBF: ">100K",
  weight: 2.8,
  cable_type: "Black Flat Ultraflex",
  rgb: "false",
  dimensions: %{
    length: 160.00,
    width: 150,
    height: 86
  }
})


alias Pcpb.App

defmodule Pcpb.Seeds do


  def insert do
    memory_id = generate_part_id(:memory)
    create_memory(%{
      id: memory_id,
      name: "Trident Z RGB",
      manufacturer: "G.SKILL",
      model: "G.SKILL Trident Z RGB DDR4-3600 CL1",
      model_number: "F4-3600C18D-16GTZRX",
      launch: ~D[2017-11-01],
      color: "Black / LED",
      series: "Trident Z RGB",
      type: "288-Pin DDR4 SDRAM",
      chipset: "Intel XMP 2.0",
      heatsink: "Anodized Aluminum",
      module_size: "8GB",
      speed: "3200MHz",
      speeed_rating: "PC4-28800",
      cas_latency: "18",
      timing: "18-22-22-42",
      voltage: "1.35V",
      ecc: "false",
      ecc_rank: "",
      led: "Individually Addressable",
    })
    for x <- 0..50 do
      Pcpb.App.create_product(%{
        name: "#{x} gskill test",
        part_type: :memory,
        part_id: memory_id
      })
    end

    # Enum.each(0..50, fn x ->
    #   # IO.inspect(x)
    #   Pcpb.App.create_product(%{
    #     name: "#{x} gskill test",
    #     part_type: :memory,
    #     part: memory_id
    #   })
    # end)
    # Enum.each(0..50, fn x ->
    #   IO.inspect(x <> "gskill test")
    # #  Pcpb.App.create_product(%{
    # #     id: Pcpb.App.generate_product_id,
    # #     name: x <> "gskill test",
    # #     part_type: :memory,
    # #     part: memory_id
    # #   })
    # end)
  end
end

Pcpb.Seeds.insert()
