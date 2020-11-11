defmodule PcpbWeb.CPULive.FormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.Parts

  @impl true
  def update(%{cpu: cpu} = assigns, socket) do
    changeset = Parts.change_cpu(cpu)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"cpu" => cpu_params}, socket) do
    changeset =
      socket.assigns.cpu
      |> Parts.change_cpu(cpu_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cpu" => cpu_params}, socket) do
    save_cpu(socket, socket.assigns.action, cpu_params)
  end

  defp save_cpu(socket, :edit, cpu_params) do
    case Parts.update_cpu(socket.assigns.cpu, cpu_params) do
      {:ok, _cpu} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cpu updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cpu(socket, :new, cpu_params) do
    case Parts.create_cpu(cpu_params) do
      {:ok, _cpu} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cpu created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end