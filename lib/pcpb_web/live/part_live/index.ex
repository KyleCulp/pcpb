defmodule PcpbWeb.PartLive.Index do
  use PcpbWeb, :live_view

  alias Pcpb.Parts
  alias Pcpb.Parts.Part

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :parts, list_parts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Part")
    |> assign(:part, Parts.get_part!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Part")
    |> assign(:part, %Part{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Parts")
    |> assign(:part, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    part = Parts.get_part!(id)
    {:ok, _} = Parts.delete_part(part)

    {:noreply, assign(socket, :parts, list_parts())}
  end

  defp list_parts do
    Parts.list_parts()
  end

  def handle_info(message, socket) do
    IO.puts("Got message from broadcast")
    {:noreply, socket}
  end
end
