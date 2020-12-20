defmodule PcpbWeb.AdminLive.Parts.MemoryFormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.Parts

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/memory_form.html", assigns)
  end

  @impl true
  def update(%{part: memory} = assigns, socket) do
    changeset = Parts.change_memory(memory)

    autocomplete_lists = Parts.autocomplete_lists("memorys", ["type", "manufacturer", "color", "chipset", "led"])

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:autocomplete_lists, autocomplete_lists)}
  end

  @impl true
  def handle_event("validate", %{"memory" => memory_params}, socket) do
    changeset =
      socket.assigns.part
      |> Parts.change_memory(memory_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"memory" => memory_params}, socket) do
    save_memory(socket, socket.assigns.action, memory_params)
  end

  defp save_memory(socket, :edit, memory_params) do
    case Parts.update_memory(socket.assigns.part, memory_params) do
      {:ok, _memory} ->
        {:noreply,
         socket
         |> put_flash(:info, "Memory updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_memory(socket, :new, memory_params) do
    case Parts.create_memory(memory_params) do
      {:ok, _memory} ->
        {:noreply,
         socket
         |> put_flash(:info, "Memory created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
