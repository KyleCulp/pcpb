defmodule PcpbWeb.AdminView do
  use PcpbWeb, :view

  def create_parts(socket) do
    [
      %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)},
      %{name: "Case", route: Routes.admin_parts_case_path(socket, :index)}
      # %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)}
    ]
  end
end
