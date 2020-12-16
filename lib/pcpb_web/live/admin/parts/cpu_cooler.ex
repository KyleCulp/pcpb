defmodule PcpbWeb.AdminLive.Parts.CPUCooler do
  use PcpbWeb, :live_view

  alias Pcpb.Parts
  alias Pcpb.Parts.CPUCooler

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/cpu_cooler.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cpu_coolers, list_cpu_coolers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cpu cooler")
    |> assign(:cpu_cooler, Parts.get_cpu_cooler!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cpu cooler")
    |> assign(:cpu_cooler, %CPUCooler{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cpu coolers")
    |> assign(:cpu_cooler, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cpu_cooler = Parts.get_cpu_cooler!(id)
    {:ok, _} = Parts.delete_cpu_cooler(cpu_cooler)

    {:noreply, assign(socket, :cpu_coolers, list_cpu_coolers())}
  end

  defp list_cpu_coolers do
    Parts.list_cpu_coolers()
  end
end
