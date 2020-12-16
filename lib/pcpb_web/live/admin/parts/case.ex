defmodule PcpbWeb.AdminLive.Parts.Case do
  use PcpbWeb, :live_admin_view

  alias Pcpb.Parts
  alias Pcpb.Parts.Case

  def render(assigns) do
    ~L"""
    <%= if @live_action in [:new, :edit] do %>
    <%= live_modal @socket, @form_component,
          id: @case.id || :new,
          title: @page_title,
          action: @live_action,
          case: @case,
          return_to: Routes.admin_parts_case_path(@socket, :index) %>
  <% end %>
  <div class="content-center justify-center min-w-full pt-20 mx-auto">
  <table>
    <thead>
      <tr>
        <th>Name</th>
        <th>Manufacturer</th>
        <th>Model</th>
        <th>Launch</th>
        <th></th>
      </tr>
    </thead>
    <tbody id="parts">
      <%= for part <- @parts do %>
        <tr id="case-<%= part.id %>">
          <td><%= live_patch part.name, to: part.edit_route(@socket, :edit, part) %></td>
          <td><%= part.manufacturer %></td>
          <td><%= part.model %></td>
          <td><%= part.launch %></td>
          <td>
            <span><%= live_patch "Edit", to: Routes.admin_parts_case_path(@socket, :edit, part) %></span>
            <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: part.id, data: [confirm: "Are you sure?"] %></span>
          </td>
        </tr>
      <% end %>
    </tbody>
  </table>
  <span><%= live_patch "New Case", to: Routes.admin_parts_case_path(@socket, :new) %></span>
</div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:parts, list_cases())
    |> assign(:form_component, PcpbWeb.AdminLive.Parts.CaseFormComponent)
  }
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
