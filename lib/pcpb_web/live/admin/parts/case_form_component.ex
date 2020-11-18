defmodule PcpbWeb.AdminLive.Parts.CaseFormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.Parts

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/case_form.html", assigns)
  end

  @impl true
  def update(%{case: case} = assigns, socket) do
    changeset = Parts.change_case(case)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
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
