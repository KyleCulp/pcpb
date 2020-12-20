defmodule PcpbWeb.AdminLive.Parts.PSUFormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.Parts

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/psu_form.html", assigns)
  end

  @impl true
  def update(%{part: psu} = assigns, socket) do
    changeset = Parts.change_psu(psu)
    # tag_lists = Parts.list_array_suggestions("psus", ["output"])
    autocomplete_lists = Parts.autocomplete_lists("psus", ["type", "manufacturer", "color", "form_factor", "modular", "efficiency", "rating", "main_connector", "pci_express_connector"])

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:autocomplete_lists, autocomplete_lists)}
  end

  @impl true
  def handle_event("validate", %{"psu" => psu_params}, socket) do
    changeset =
      socket.assigns.part
      |> Parts.change_psu(psu_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"psu" => psu_params}, socket) do
    save_psu(socket, socket.assigns.action, psu_params)
  end

  defp save_psu(socket, :edit, psu_params) do
    case Parts.update_psu(socket.assigns.part, psu_params) do
      {:ok, _psu} ->
        {:noreply,
         socket
         |> put_flash(:info, "PSU updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_psu(socket, :new, psu_params) do
    case Parts.create_psu(psu_params) do
      {:ok, _psu} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cpu cooler created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
