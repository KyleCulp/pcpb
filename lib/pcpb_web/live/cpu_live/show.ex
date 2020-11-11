defmodule PcpbWeb.CPULive.Show do
  use PcpbWeb, :live_view

  alias Pcpb.Parts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cpu, Parts.get_cpu!(id))}
  end

  defp page_title(:show), do: "Show Cpu"
  defp page_title(:edit), do: "Edit Cpu"
end
