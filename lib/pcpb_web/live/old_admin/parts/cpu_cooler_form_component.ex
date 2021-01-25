defmodule PcpbWeb.AdminLive.Parts.CPUCoolerFormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.Parts

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.OldAdminView, "parts/cpu_cooler_form.html", assigns)
  end

  @impl true
  def update(%{part: cpu_cooler} = assigns, socket) do
    changeset = Parts.change_cpu_cooler(cpu_cooler)
    tag_lists = Parts.list_array_suggestions("cpu_coolers", ["socket_support"])
    autocomplete_lists = Parts.autocomplete_lists("cpu_coolers", ["type", "manufacturer", "color"])

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:autocomplete_lists, autocomplete_lists)
     |> assign(:tag_lists, tag_lists)}
  end

  @impl true
  def handle_event("validate", %{"cpu_cooler" => cpu_cooler_params}, socket) do
    changeset =
      socket.assigns.part
      |> Parts.change_cpu_cooler(cpu_cooler_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cpu_cooler" => cpu_cooler_params}, socket) do
    save_cpu_cooler(socket, socket.assigns.action, cpu_cooler_params)
  end

  defp save_cpu_cooler(socket, :edit, cpu_cooler_params) do
    case Parts.update_cpu_cooler(socket.assigns.part, cpu_cooler_params) do
      {:ok, _cpu_cooler} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cpu cooler updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cpu_cooler(socket, :new, cpu_cooler_params) do
    case Parts.create_cpu_cooler(cpu_cooler_params) do
      {:ok, _cpu_cooler} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cpu cooler created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
