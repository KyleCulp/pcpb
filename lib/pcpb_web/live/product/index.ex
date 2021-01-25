defmodule PcpbWeb.ProductLive.Index do
  use PcpbWeb, :live_view

  alias Pcpb.App
  alias Pcpb.App.Product

  @impl true
  def mount(_params, session, socket) do
    user = Pcpb.Users.get_current_user!(session)
    socket = socket
      |> assign(:products, list_products())
      |> assign(:user, user)
      |> assign(:category, "")

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = App.get_product!(id)
    IO.inspect(PcpbWeb.Router.Helpers.product_show_path(socket, :index, product.part_type, product.id))
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, product)
    |> assign(:category, "edit")
    |> assign(:return_route, PcpbWeb.Router.Helpers.product_show_path(socket, :index, product.part_type, product.id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, %{"category" => category}) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:products, App.list_products(category))
    |> assign(:product, nil)
    |> assign(:category, category)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
    |> assign(:category, "index")
  end

  def handle_event("delete", %{"id" => id}, socket) do
    product = App.get_product!(id)
    {:ok, _} = App.delete_product(product)

    {:noreply, assign(socket, :products, list_products())}
  end

  defp list_products do
    App.list_products()
  end
end
