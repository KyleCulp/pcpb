defmodule PcpbWeb.AdminLive.Parts.Index do
  use PcpbWeb, :live_admin_view
  alias Pcpb.Parts

  defp create_parts(socket) do
    [
      %{name: "CPU", action: :cpu},
      %{name: "CPU Cooler", action: :cpu_cooler},
      %{name: "Case", action: :case},
      %{name: "GPU", action: :gpu},
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
