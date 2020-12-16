defmodule PcpbWeb.AdminLive.Parts.Index do
  use PcpbWeb, :live_admin_view
  alias Pcpb.Parts

  defp create_parts(socket) do
    [
      %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index), form: PcpbWeb.AdminLive.Parts.CPUFormComponent},
      %{name: "Case", route: Routes.admin_parts_case_path(socket, :index), form: PcpbWeb.AdminLive.Parts.CaseFormComponent},
      %{name: "CPU Cooler", route: Routes.admin_parts_cpu_cooler_path(socket, :index), form: PcpbWeb.AdminLive.Parts.CPUCoolerFormComponent}
    ]
  end

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/index.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign(:parts, create_parts(socket))
  }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Parts")
  end

  defp list_cpus do
    Parts.list_cpus()
  end
end
