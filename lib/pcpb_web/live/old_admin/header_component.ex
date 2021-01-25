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

  @impl true
  def render(assigns) do
    ~L"""
    <nav id="header" class="fixed top-0 z-10 w-full bg-gray-900 shadow">
    <div class="container flex flex-wrap items-center w-full pt-3 pb-3 mx-auto mt-0 md:pb-0">
    <div class="w-1/2 pl-2 md:pl-0">
      <%= live_patch to: Routes.admin_index_path(@socket, :index) do %>
        <span class="text-base font-bold text-gray-100 no-underline xl:text-xl hover:no-underline">
          <i class="pr-3 text-blue-400 fas fa-moon"></i> PCPartBuilder Admin
        </span>
      <% end %>
    </div>
    <div class="w-1/2 pr-0">
      <div class="relative flex inline-block float-right">
        <div class="relative text-sm text-gray-100">
          <button id="userButton" class="flex items-center mr-3 focus:outline-none">

            <svg class="h-2 pl-2 text-gray-100 fill-current" version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 129 129" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 129 129"><g><path d="m121.3,34.6c-1.6-1.6-4.2-1.6-5.8,0l-51,51.1-51.1-51.1c-1.6-1.6-4.2-1.6-5.8,0-1.6,1.6-1.6,4.2 0,5.8l53.9,53.9c0.8,0.8 1.8,1.2 2.9,1.2 1,0 2.1-0.4 2.9-1.2l53.9-53.9c1.7-1.6 1.7-4.2 0.1-5.8z"/></g></svg>
          </button>
          <div id="userMenu" class="absolute top-0 right-0 z-30 invisible min-w-full mt-2 mt-12 overflow-auto bg-gray-900 rounded shadow-md">
            <ul class="list-reset">
              <li><a href="#" class="block px-4 py-2 text-gray-100 no-underline hover:bg-gray-800 hover:no-underline">My account</a></li>
              <li><a href="#" class="block px-4 py-2 text-gray-100 no-underline hover:bg-gray-800 hover:no-underline">Notifications</a></li>
              <li><hr class="mx-2 border-t border-gray-400"></li>
              <li><a href="#" class="block px-4 py-2 text-gray-100 no-underline hover:bg-gray-800 hover:no-underline">Logout</a></li>
            </ul>
          </div>
        </div>
        <div class="block pr-4 lg:hidden">
          <button id="nav-toggle" class="flex items-center px-3 py-2 text-gray-500 border border-gray-600 rounded appearance-none hover:text-gray-100 hover:border-teal-500 focus:outline-none">
            <svg class="w-3 h-3 fill-current" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"/></svg>
          </button>
        </div>
      </div>
    </div>
    <div class="z-20 flex-grow hidden w-full mt-2 bg-gray-900 lg:flex lg:items-center lg:w-auto lg:block lg:mt-0" id="nav-content">
      <ul class="items-center flex-1 px-4 list-reseqt lg:flex md:px-0">
      <%= Enum.with_index(@nav_items) |> Enum.map(fn({item, index}) -> %>
      <li>
        <%= live_patch to: item.route do %>
        <li class="my-2 mr-6 md:my-0">
        <span class="block py-1 md:py-3 pl-1 align-middle no-underline hover:text-gray-100 border-b-2 hover:border-blue-400 <%= if Enum.at(@nav_items, 1).route == "/admin/parts", do: "text-blue-400 border-blue-400", else: "border-gray-900" %>">
          <i class="mr-3 text-blue-400 fas fa-home fa-fw"></i><span class="pb-1 text-sm md:pb-0"><%= item.name %></span>
        </span>
      </li>
        <% end %>
        </li>
    <% end) %>
      </ul>
      <div class="relative pl-4 pr-4 pull-right md:pr-0">
        <input type="search" placeholder="Search" class="w-full px-2 py-1 pl-10 text-sm leading-normal text-gray-400 transition bg-gray-900 border border-gray-800 rounded appearance-none focus:outline-none focus:border-gray-600">
        <div class="absolute search-icon" style="top: 0.375rem;left: 1.75rem;">
          <svg class="w-4 h-4 text-gray-500 pointer-events-none fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
            <path d="M12.9 14.32a8 8 0 1 1 1.41-1.41l5.35 5.33-1.42 1.42-5.33-5.34zM8 14A6 6 0 1 0 8 2a6 6 0 0 0 0 12z"></path>
          </svg>
        </div>
      </div>
    </div>
    </div>
    </nav>
    """
  end
end
