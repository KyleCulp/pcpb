defmodule PcpbWeb.AdminLive.Parts.CaseFormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.Parts

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/case_form.html", assigns)
  end

  @impl true
  def update(%{case: case} = assigns, socket) do
    changeset = Parts.change_case(case)
    # manufacturer_options = Parts.list_suggestions("cases", "manufacturer")
    # motherboard_support_options = Parts.list_array_suggestions("cases", "motherboard_support")
    # psu_support_options = Parts.list_array_suggestions("cases", "psu_support")

    autocomplete_lists = Parts.simple_autocomplete_lists("cases", ["type", "manufacturer"])
    tag_lists = Parts.list_array_suggestions("cases", ["motherboard_support", "psu_support", "io"])

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:autocomplete_lists, autocomplete_lists)
     |> assign(:tag_lists, tag_lists)}
  end

  @impl true
  def handle_event("validate", %{"case" => case_params}, socket) do
    changeset =
      socket.assigns.case
      |> Parts.change_case(case_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"case" => case_params}, socket) do
    save_case(socket, socket.assigns.action, case_params)
  end

  defp save_case(socket, :edit, case_params) do
    case Parts.update_case(socket.assigns.case, case_params) do
      {:ok, _case} ->
        {:noreply,
         socket
         |> put_flash(:info, "Case updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_case(socket, :new, case_params) do
    case Parts.create_case(case_params) do
      {:ok, _case} ->
        {:noreply,
         socket
         |> put_flash(:info, "Case created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
