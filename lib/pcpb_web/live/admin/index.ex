defmodule PcpbWeb.AdminLive.Index do
  use PcpbWeb, :live_admin_view

  def render(assigns) do
    Phoenix.View.render(PcpbWeb.AdminView, "index.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
