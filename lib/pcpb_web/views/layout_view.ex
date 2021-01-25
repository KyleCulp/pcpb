defmodule PcpbWeb.LayoutView do
  use PcpbWeb, :view

  def products_map do
    [
      %{name: "CPU", atom: :cpu, icon: ""},
      %{name: "CPU Cooler", atom: :cpu_cooler, icon: ""},
      %{name: "Case", atom: :case, icon: ""},
      %{name: "Memory", atom: :memory, icon: ""},
      %{name: "Motherboard", atom: :motherboard, icon: ""},
      %{name: "PSU", atom: :psu, icon: ""},
      %{name: "GPU", atom: :gpu, icon: ""},
      %{name: "Storage", atom: :storage, icon: ""},
      %{name: "PSU", atom: :psu, icon: ""}
    ]
  end

  def nav_classes do
    "p-5 hover:bg-red-500 text-pcpbblue hover:text-white no-underline hover:no-underline items-center inline-flex"
  end
end
