    mix phx.gen.live Parts CPU cpus name manufacturer model model_year series family integrated_graphics max_memory:integer memory_channels:integer smt core_count:integer core_clock:integer boost_clock:integer cache tdp:integer boost_tdp:integer lithography stock_cooler

mix phx.gen.live Parts Case cases name manufacturer model release:date model_number color type motherboard_support:array:string psu_support:array:string included_psu psu_shroud psu_mount_location windows:map dimensions:map clearance:map weight:decimal io:map dust_filters:map expansion_slots:map radiator_support:map fan_options:map
^ Todo: Add TDP


mix phx.gen.live Parts CPUCooler cpu_coolers name manufacturer model series release:date model_number color led type intel_socket_support:array:string amd_socket_support:array:string bearing_type fans:integer fan_size:integer rpm noise_level fan_cfm dimensions:map watercool:map fan_dimensions rgb

mix phx.gen.context Parts GPU gpus name manufacturer model series release:date model_number interface chipset GPU core_clock:decimal boost_clock:decimal memory_clock frame_sync cuda_cores:integer stream_processors:integer memory memory_clock memory_interface memory_type directx opengl max_resolution max_monitors io:map power_connector hdcp slot_width dimensions:map cooler sli_support crossfire_support ray_tracing backplate virtuallink rgb


mix phx.gen.context Parts Motherboard motherboards form_factor socket chipset memory_type memory_dimms max_memory:integer memory_channels memory_speed:array:string memory_oc_speed:array:string pciex16:array:string pciex8:array:string pciex4:array:string pciex1:array:string pci:integer sata3 sata6 msata sata_raid m2:array:string power_pins:array:string sli crossfire lan lan_speed video usb2_headers usb3usb_three_two_gen_one usb_three_two_gen_two video audio_chipset audio_channels bluetooth wifi color led intel_optane backplate liquid_cooling

mix phx.gen.context Parts Memory memorys name manufacturer model launch:date model_number series color led type chipset modules speed cas_latency:integer voltage timing heatsink ecc ecc_rank

mix phx.gen.context Parts PSU psus series color led type form_factor wattage:integer modular efficiency rating main_connector 12v_rails pci_express_connector sata_connectors input_voltage input_current MTBF dimensions:map weight:integer cable_type rgb fanless fan_size fan_bearing
