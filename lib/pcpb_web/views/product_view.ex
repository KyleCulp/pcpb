defmodule PcpbWeb.ProductsView do
  use PcpbWeb, :view

  # def get_part(socket, action) do
  #   [
  #     %{name: "CPU", action: :cpu, edit_action: :cpu_edit, form: PcpbWeb.AdminLive.Parts.CPUFormComponent},
  #     %{name: "CPU Cooler", action: :cpu_cooler, edit_action: :cpu_cooler_edit, form: PcpbWeb.AdminLive.Parts.CPUCoolerFormComponent}
  #     %{name: "Case", action: :case, edit_action: :case_edit, form: PcpbWeb.AdminLive.Parts.CaseFormComponent},
  #       # %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)}
  #   ]
  #   |> Enum.filter(fn part -> part.action == action end)
  # end

  # def part_edit_path(socket, action, part) do
  #   live_patch part.name, to: part.admin_parts_edit_path(@socket, :edit, part)
  # end

  def form_classes do
    "grid grid-cols-2 gap-x-1 md:grid-cols-4 2xl:grid-cols-6 flex-wrap justify-center px-4 min-w-full"
  end

  def cdn_url, do: Application.fetch_env!(:pcpb, :url)
end
