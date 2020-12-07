defmodule PcpbWeb.AdminLive.Parts.Case do
  use PcpbWeb, :live_admin_view

  alias Pcpb.Parts
  alias Pcpb.Parts.Case

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "parts/case.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cases, list_cases())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Case")
    |> assign(:case, Parts.get_case!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Case")
    |> assign(:case, %Case{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cases")
    |> assign(:case, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    case = Parts.get_case!(id)
    {:ok, _} = Parts.delete_case(case)

    {:noreply, assign(socket, :cases, list_cases())}
  end

  defp list_cases do
    Parts.list_cases()
  end
end
