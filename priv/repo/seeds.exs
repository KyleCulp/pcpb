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
alias Pcpb.Parts.{CPU, Case, CPUCooler}

%User{admin: true}
|> User.changeset(%{
  email: "admin@pcpb.app",
  password: "12345678",
  password_confirmation: "12345678"
})
|> Repo.insert!()

%CPU{}
|> CPU.changeset(%{
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
  tdp: 125,
    dimensions: %{
    length: 0,
    width: 0,
    height: 0
  },
})
|> Repo.insert!()

%CPU{}
|> CPU.changeset(%{
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
  tdp: 125,
  dimensions: %{
    length: 0,
    width: 0,
    height: 0
    },
    })
|> Repo.insert!()

%Case{}
|> Case.changeset(%{
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
|> Repo.insert!()

%Case{}
|> Case.changeset(%{
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
|> Repo.insert!()

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
# |> Repo.insert!()
  %CPUCooler{}
  |> CPUCooler.changeset(%{
    name: "Corsair H100i RGB PLATINUM",
    manufacturer: "Corsair",
    model: "Corsair H100i RGB PLATINUM 75 CFM Liquid CPU Cooler",
    model_number: "CW-9060039-WW",
    launch: ~D[2020-04-18],
    color: "Black / Silver",
    led: "fan leds / corsair icue block",
    type: "Liquid Cooling System",
    socket_support: ["AM2", "AM2+",
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
    "LGA2066"],
    bearing_type: "Magnetic Levitation",
    fans: "2 x 120mm",
    fan_size: "120mm x 25mm",
    fan_cfm: "75",
    fan_rpm: "2700",
    noise_level: "37",
    radiator: "240mm",
    dimensions: %{
      length: 277.00,
      width: 120,
      height: 27
    }
  })
  |> Repo.insert!()
