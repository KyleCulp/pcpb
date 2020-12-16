defmodule PcpbWeb.AdminLive.Parts.Part do
  use PcpbWeb, :live_admin_view

  alias Pcpb.Parts
  alias Pcpb.Parts.{CPU, CPUCooler, Case}

  def get_part(action) do
    [
      %{name: "CPU", action: :cpu, edit_action: :cpu_edit, form: PcpbWeb.AdminLive.Parts.CPUFormComponent},
      %{name: "CPU Cooler", action: :cpu_cooler, edit_action: :cpu_cooler_edit, form: PcpbWeb.AdminLive.Parts.CPUCoolerFormComponent},
      %{name: "Case", action: :case, edit_action: :case_edit, form: PcpbWeb.AdminLive.Parts.CaseFormComponent}
        # %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)}
    ]
    |> Enum.filter(fn part -> part.action == action end)
  end

  def render(assigns) do
    IO.inspect(get_part(assigns.live_action))
    Phoenix.View.render(PcpbWeb.AdminView, "parts/part.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
  }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :cpu, _params) do
    socket
    |> assign(:page_title, "CPUs")
    |> assign(:parts, Parts.list_cpus())
  end

  defp apply_action(socket, :cpu_edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cpu")
    |> assign(:part, Parts.get_cpu!(id))
  end

  defp apply_action(socket, :cpu_new, _params) do
    socket
    |> assign(:page_title, "New Cpu")
    |> assign(:part, %CPU{})
  end

  defp apply_action(socket, :cpu_cooler, _params) do
    socket
    |> assign(:page_title, "CPU Coolers")
    |> assign(:parts, Parts.list_cpu_coolers())
  end

  defp apply_action(socket, :cpu_cooler_edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cpu")
    |> assign(:part, Parts.get_cpu_cooler!(id))
  end

  defp apply_action(socket, :cpu_cooler_new, _params) do
    socket
    |> assign(:page_title, "New Cpu")
    |> assign(:part, %CPUCooler{})
  end




  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   cpu = Parts.get_cpu!(id)
  #   {:ok, _} = Parts.delete_cpu(cpu)

  #   {:noreply, assign(socket, :parts, Parts.list_cpus())}
  # end
end
