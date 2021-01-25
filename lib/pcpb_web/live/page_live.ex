defmodule PcpbWeb.PageLive do
  use PcpbWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    user = Pcpb.Users.get_current_user!(session)
    {:ok, assign(socket, query: "", results: %{}, user: user)}
  end

end
