defmodule PcpbWeb.AdminLive.Parts.Part do
  use PcpbWeb, :live_admin_view

  alias Pcpb.Parts
  alias Pcpb.Parts.{CPU, CPUCooler, Case, GPU}

  def get_part(action) do
    [
      %{name: "CPU", action: :cpu, new: :cpu_new, edit: :cpu_edit, form: PcpbWeb.AdminLive.Parts.CPUFormComponent},
      %{name: "CPU Cooler", action: :cpu_cooler, new: :cpu_cooler_new, edit: :cpu_cooler_edit, form: PcpbWeb.AdminLive.Parts.CPUCoolerFormComponent},
      %{name: "Case", action: :case, new: :case_new, edit: :case_edit, form: PcpbWeb.AdminLive.Parts.CaseFormComponent},
      %{name: "GPU", action: :gpu, new: :gpu_new, edit: :gpu_edit, form: PcpbWeb.AdminLive.Parts.GPUFormComponent},
      # %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)}
    ]
    |> Enum.filter(fn part -> (part.action == action) or (part.edit == action) or (part.new == action)end)
  end

  def render(assigns) do

    Phoenix.View.render(PcpbWeb.AdminView, "parts/part.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:part_data, List.first(get_part(socket.assigns.live_action)))
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
    |> assign(:page_title, "Edit CPU")
    |> assign(:parts, Parts.list_cpus())
    |> assign(:part, Parts.get_cpu!(id))
  end

  defp apply_action(socket, :cpu_new, _params) do
    socket
    |> assign(:page_title, "New CPU")
    |> assign(:parts, Parts.list_cpus())
    |> assign(:part, %CPU{})
  end

  defp apply_action(socket, :cpu_cooler, _params) do
    socket
    |> assign(:page_title, "CPU Coolers")
    |> assign(:parts, Parts.list_cpu_coolers())
  end

  defp apply_action(socket, :cpu_cooler_edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit CPU Cooler")
    |> assign(:parts, Parts.list_cpu_coolers())
    |> assign(:part, Parts.get_cpu_cooler!(id))
  end

  defp apply_action(socket, :cpu_cooler_new, _params) do
    socket
    |> assign(:page_title, "New CPU Cooler")
    |> assign(:parts, Parts.list_cpu_coolers())
    |> assign(:part, %CPUCooler{})
  end

  defp apply_action(socket, :case, _params) do
    socket
    |> assign(:page_title, "Cases")
    |> assign(:parts, Parts.list_cases())
  end

  defp apply_action(socket, :case_edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cases")
    |> assign(:parts, Parts.list_cases())
    |> assign(:part, Parts.get_case!(id))
  end

  defp apply_action(socket, :case_new, _params) do
    socket
    |> assign(:page_title, "New Case")
    |> assign(:parts, Parts.list_cases())
    |> assign(:part, %Case{})
  end

  defp apply_action(socket, :gpu, _params) do
    socket
    |> assign(:page_title, "GPUs")
    |> assign(:parts, Parts.list_gpus())
  end

  defp apply_action(socket, :gpu_edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit GPUs")
    |> assign(:parts, Parts.list_gpus())
    |> assign(:part, Parts.get_gpu!(id))
  end

  defp apply_action(socket, :gpu_new, _params) do
    socket
    |> assign(:page_title, "New GPU")
    |> assign(:parts, Parts.list_gpus())
    |> assign(:part, %GPU{})
  end



  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   cpu = Parts.get_cpu!(id)
  #   {:ok, _} = Parts.delete_cpu(cpu)

  #   {:noreply, assign(socket, :parts, Parts.list_cpus())}
  # end
end
