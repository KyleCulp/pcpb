defmodule PcpbWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  # Most of this code is referenced from phoenix_dashboard's helpers.ex

  @doc """
  Renders a component inside the `PcpbWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, PcpbWeb.CPULive.FormComponent,
        id: @cpu.id || :new,
        action: @live_action,
        cpu: @cpu,
        return_to: Routes.cpu_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, PcpbWeb.ModalComponent, modal_opts)
  end

  @doc """
  Computes a route path to the given route, node, and params.
  """
  def live_dashboard_path(socket, route, node, old_params, new_params) when is_atom(node) do
    apply(
      socket.router.__helpers__(),
      :live_dashboard_path,
      if node == node() and is_nil(old_params["node"]) do
        [socket, :page, route, new_params]
      else
        [socket, :page, node, route, new_params]
      end
    )
  end

   @doc """
  Computes a router path to the current page.
  """
  def live_dashboard_path(socket, %{route: route, node: node, params: params}) do
    live_dashboard_path(socket, route, node, params, params)
  end

  @doc """
  Computes a router path to the current page with merged params.
  """
  def live_dashboard_path(socket, %{route: route, node: node, params: old_params}, extra) do
    new_params = Enum.into(extra, old_params, fn {k, v} -> {Atom.to_string(k), v} end)
    live_dashboard_path(socket, route, node, old_params, new_params)
  end

  @doc """
  Encodes Sockets for URLs.
  """
  def encode_socket(ref) do
    '#Port' ++ rest = :erlang.port_to_list(ref)
    "Socket#{rest}"
  end

  @doc """
  Encodes ETSs for URLs.
  """
  def encode_ets(ref) do
    '#Ref' ++ rest = :erlang.ref_to_list(ref)
    "ETS#{rest}"
  end

  @doc """
  Encodes PIDs for URLs.
  """
  def encode_pid(pid) do
    "PID#{:erlang.pid_to_list(pid)}"
  end

  @doc """
  Encodes Port for URLs.
  """
  def encode_port(port) when is_port(port) do
    port
    |> :erlang.port_to_list()
    |> tl()
    |> List.to_string()
  end
end
