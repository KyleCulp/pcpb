defmodule PcpbWeb.CPULive.Index do
  use PcpbWeb, :live_view

  alias Pcpb.Parts
  alias Pcpb.Parts.CPU

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cpus, list_cpus())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cpu")
    |> assign(:cpu, Parts.get_cpu!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cpu")
    |> assign(:cpu, %CPU{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cpus")
    |> assign(:cpu, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cpu = Parts.get_cpu!(id)
    {:ok, _} = Parts.delete_cpu(cpu)

    {:noreply, assign(socket, :cpus, list_cpus())}
  end

  defp list_cpus do
    Parts.list_cpus()
  end
end
