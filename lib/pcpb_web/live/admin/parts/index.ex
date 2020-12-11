defmodule PcpbWeb.AdminLive.Parts.Index do
  use PcpbWeb, :live_admin_view
  alias Pcpb.Parts

  defp create_parts(socket) do
    parts = [
      %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)},
      %{name: "Case", route: Routes.admin_parts_case_path(socket, :index)}
      # %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)}
    ]
  end

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/index.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :parts, create_parts(socket))}
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
