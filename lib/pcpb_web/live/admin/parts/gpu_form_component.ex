defmodule PcpbWeb.AdminLive.Parts.GPUFormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.Parts

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/gpu_form.html", assigns)
  end

  @impl true
  def update(%{part: gpu} = assigns, socket) do
    changeset = Parts.change_gpu(gpu)
    tag_lists = Parts.list_array_suggestions("gpus", ["io"])
    autocomplete_lists = Parts.autocomplete_lists("gpus", ["manufacturer", "color"])

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:autocomplete_lists, autocomplete_lists)
     |> assign(:tag_lists, tag_lists)}
  end

  @impl true
  def handle_event("validate", %{"gpu" => gpu_params}, socket) do
    changeset =
      socket.assigns.part
      |> Parts.change_gpu(gpu_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gpu" => gpu_params}, socket) do
    save_gpu(socket, socket.assigns.action, gpu_params)
  end

  defp save_gpu(socket, :edit, gpu_params) do
    case Parts.update_gpu(socket.assigns.part, gpu_params) do
      {:ok, _gpu} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cpu cooler updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gpu(socket, :new, gpu_params) do
    case Parts.create_gpu(gpu_params) do
      {:ok, _gpu} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cpu cooler created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
