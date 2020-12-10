defmodule PcpbWeb.Admin.HeaderComponent do
  use PcpbWeb, :live_component

  defp create_nav_items(socket) do
    nav_items = [
      %{name: "Home", route: Routes.admin_index_path(socket, :index)},
      %{name: "Parts", route: Routes.admin_parts_index_path(socket, :index)}
      # %{name: "CPU", route: Routes.admin_parts_cpu_path(socket, :index)}
    ]
  end

  @impl true
  def mount(socket) do
    {:ok, assign(socket, nav_items: create_nav_items(socket))}
  end

  # @impl true
  # def update(assigns, socket) do
  #   %{page: page, items: items} = assigns
  #   current = current_item(page.params, items)
  #   {:ok, assign(socket, nav_items: @nav_items, current: current, page: page)}
  # end

  defp current_item(params, items) do
    with %{"nav" => item} <- params,
         true <- Enum.any?(items, fn {id, _} -> Atom.to_string(id) == item end) do
      String.to_existing_atom(item)
    else
      _ -> default_item(items)
    end
  end

  defp default_item([{id, _} | _]) do
    id
  end

  def normalize_params(params) do
    case Map.fetch(params, :items) do
      :error ->
        raise ArgumentError, "expected :items parameter to be received"

      {:ok, no_list} when not is_list(no_list) ->
        msg = "expected :items parameter to be a list, received: "
        raise ArgumentError, msg <> inspect(no_list)

      {:ok, items} ->
        %{items: normalize_items(items)}
    end
  end

  def normalize_items(items) do
    Enum.map(items, &normalize_item/1)
  end

  defp normalize_item({id, item}) when is_atom(id) and is_list(item) do
    {id,
     item
     |> validate_item_render()
     |> validate_item_name()
     |> normalize_item_method()}
  end

  defp normalize_item(invalid_item) do
    msg = "expected :items to be [{atom(), [name: string(), render: component()], received: "

    raise ArgumentError, msg <> inspect(invalid_item)
  end

  defp validate_item_render(item) do
    case Keyword.fetch(item, :render) do
      :error ->
        msg = "expected :render parameter to be received in item: #{inspect(item)}"
        raise ArgumentError, msg

      {:ok, render} when is_function(render, 0) ->
        item

      {:ok, {component, args}} when is_atom(component) and is_map(args) ->
        item

      {:ok, _invalid} ->
        msg = "expected :render parameter in item to be a component, received: #{inspect(item)}"
        raise ArgumentError, msg
    end
  end

  defp validate_item_name(item) do
    case Keyword.fetch(item, :name) do
      :error ->
        msg = "expected :name parameter to be received in item: #{inspect(item)}"
        raise ArgumentError, msg

      {:ok, string} when is_binary(string) ->
        item

      {:ok, _invalid} ->
        msg = "expected :name parameter in item to be a string, received: #{inspect(item)}"
        raise ArgumentError, msg
    end
  end

  defp normalize_item_method(item) do
    case Keyword.fetch(item, :method) do
      :error ->
        [method: :patch] ++ item

      {:ok, method} when method in [:patch, :redirect] ->
        item

      {:ok, method} ->
        msg = "expected :method parameter in item to be :patch or :redirect, received: "
        raise ArgumentError, msg <> inspect(method)
    end
  end

  @impl true
  def render(assigns) do
    ~L"""
    <nav id="header" class="bg-gray-900 fixed w-full z-10 top-0 shadow">
    <div class="w-full container mx-auto flex flex-wrap items-center mt-0 pt-3 pb-3 md:pb-0">
    <div class="w-1/2 pl-2 md:pl-0">
      <%= live_patch to: Routes.admin_index_path(@socket, :index) do %>
        <span class="text-gray-100 text-base xl:text-xl no-underline hover:no-underline font-bold">
          <i class="fas fa-moon text-blue-400 pr-3"></i> PCPartBuilder Admin
        </span>
      <% end %>
    </div>
    <div class="w-1/2 pr-0">
      <div class="flex relative inline-block float-right">
        <div class="relative text-sm text-gray-100">
          <button id="userButton" class="flex items-center focus:outline-none mr-3">
            <img class="w-8 h-8 rounded-full mr-4" src="http://i.pravatar.cc/300" alt="Avatar of User"> <span class="hidden md:inline-block text-gray-100">Hi, User</span>
            <svg class="pl-2 h-2 fill-current text-gray-100" version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 129 129" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 129 129"><g><path d="m121.3,34.6c-1.6-1.6-4.2-1.6-5.8,0l-51,51.1-51.1-51.1c-1.6-1.6-4.2-1.6-5.8,0-1.6,1.6-1.6,4.2 0,5.8l53.9,53.9c0.8,0.8 1.8,1.2 2.9,1.2 1,0 2.1-0.4 2.9-1.2l53.9-53.9c1.7-1.6 1.7-4.2 0.1-5.8z"/></g></svg>
          </button>
          <div id="userMenu" class="bg-gray-900 rounded shadow-md mt-2 absolute mt-12 top-0 right-0 min-w-full overflow-auto z-30 invisible">
            <ul class="list-reset">
              <li><a href="#" class="px-4 py-2 block text-gray-100 hover:bg-gray-800 no-underline hover:no-underline">My account</a></li>
              <li><a href="#" class="px-4 py-2 block text-gray-100 hover:bg-gray-800 no-underline hover:no-underline">Notifications</a></li>
              <li><hr class="border-t mx-2 border-gray-400"></li>
              <li><a href="#" class="px-4 py-2 block text-gray-100 hover:bg-gray-800 no-underline hover:no-underline">Logout</a></li>
            </ul>
          </div>
        </div>
        <div class="block lg:hidden pr-4">
          <button id="nav-toggle" class="flex items-center px-3 py-2 border rounded text-gray-500 border-gray-600 hover:text-gray-100 hover:border-teal-500 appearance-none focus:outline-none">
            <svg class="fill-current h-3 w-3" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"/></svg>
          </button>
        </div>
      </div>
    </div>
    <div class="w-full flex-grow lg:flex lg:items-center lg:w-auto hidden lg:block mt-2 lg:mt-0 bg-gray-900 z-20" id="nav-content">
      <ul class="list-reseqt lg:flex flex-1 items-center px-4 md:px-0">
      <%= Enum.with_index(@nav_items) |> Enum.map(fn({item, index}) -> %>
      <li>
        <%= live_patch to: item.route do %>
        <li class="mr-6 my-2 md:my-0">
        <span class="block py-1 md:py-3 pl-1 align-middle no-underline hover:text-gray-100 border-b-2 hover:border-blue-400 <%= if Enum.at(@nav_items, 1).route == "/admin/parts", do: "text-blue-400 border-blue-400", else: "border-gray-900" %>">
          <i class="fas fa-home fa-fw mr-3 text-blue-400"></i><span class="pb-1 md:pb-0 text-sm"><%= item.name %></span>
        </span>
      </li>
        <% end %>
        </li>
    <% end) %>
      </ul>
      <div class="relative pull-right pl-4 pr-4 md:pr-0">
        <input type="search" placeholder="Search" class="w-full bg-gray-900 text-sm text-gray-400 transition border border-gray-800 focus:outline-none focus:border-gray-600 rounded py-1 px-2 pl-10 appearance-none leading-normal">
        <div class="absolute search-icon" style="top: 0.375rem;left: 1.75rem;">
          <svg class="fill-current pointer-events-none text-gray-500 w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
            <path d="M12.9 14.32a8 8 0 1 1 1.41-1.41l5.35 5.33-1.42 1.42-5.33-5.34zM8 14A6 6 0 1 0 8 2a6 6 0 0 0 0 12z"></path>
          </svg>
        </div>
      </div>
    </div>
    </div>
    </nav>
    """
  end

  defp render_item_link(socket, page, item, current, id) do
    # The nav ignores all params, except the current node if any
    path = live_dashboard_path(socket, page.route, page.node, page.params, nav: id)
    class = "nav-link#{if current == id, do: " active"}"

    case item[:method] do
      :patch -> live_patch(item[:name], to: path, class: class)
      :redirect -> live_redirect(item[:name], to: path, class: class)
    end
  end

  defp render_content(socket, page, component_or_fun) do
    case component_or_fun do
      {component, component_assigns} ->
        live_component(socket, component, Map.put(component_assigns, :page, page))

      fun when is_function(fun, 0) ->
        render_content(socket, page, fun.())

      # TODO: Remove me once we port metrics
      %Phoenix.LiveView.Rendered{} = other ->
        other
    end
  end
end
