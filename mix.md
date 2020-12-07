    mix phx.gen.live Parts CPU cpus name manufacturer model model_year series family integrated_graphics max_memory:integer memory_channels:integer smt core_count:integer core_clock:integer boost_clock:integer cache tdp:integer boost_tdp:integer lithography stock_cooler

mix phx.gen.live Parts Case cases name manufacturer model release:date model_number color type motherboard_support:array:string psu_support:array:string included_psu psu_shroud psu_mount_location windows:map dimensions:map clearance:map weight:decimal io:map dust_filters:map expansion_slots:map radiator_support:map fan_options:map
^ Todo: Add TDP


mix phx.gen.live Parts CPUCooler cpu_coolers name manufacturer model series release:date model_number color led type intel_socket_support:array:string amd_socket_support:array:string bearing_type fans:integer fan_size:integer rpm noise_level fan_cfm dimensions:map watercool:map fan_dimensions rgb

mix phx.gen.live Parts GPU gpus name manufacturer model series release:date model_number interface chipset GPU base_clock:decimal boost_clock:decimal memory_clock:decimal frame_sync cuda_cores:integer stream_processors:integer memory memory_clock memory_interface memory_type directx opengl max_resolution max_monitors io:map power_connector hdcp slot_width dimensions:map cooler length:integer sli_support crossfire_support ray_tracing backplate virtuallink rgb


mix phx.gen.live Parts Motherboard motherboards name manufacturer model release:date model_number color led  form_factor socket chipset memory_type memory_slots max_memory:integer memory_channel memory_speed:array:string pci_version pciex16:integer pciex8:integer pciex4:integer pciex1:integer pci:integer sata3 sata6 msata m2:array:string raid sli crossfire ethernet_chipset ethernet2_chipset video usb2 usb321 usb322 usb3222 video audio_chipset audio_channels wireless

mix phx.gen.live Parts Memory memorys name manufacturer model release:date model_number color led type chipset  modules speed cas_latency:integer voltage timing heatsink ecc

mix phx.gen.live Parts PSU psus name manufacturer model release:date model_number color led type wattage:integer fan main_connector 12v_rails pci_express_connector dimensions:map length:integer
