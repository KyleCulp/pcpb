defmodule PcpbWeb.ProductLive.Show do
  use PcpbWeb, :live_view

  alias Pcpb.App

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign(:user, Pcpb.Users.get_current_user!(session))

    {:ok, socket}
  end

  def handle_event("imagechange", %{"image_id" => image_id, "old_index" => old_index, "new_index" => new_index}, socket) do
    images = Pcpb.App.swap(socket.assigns.product.images, old_index, new_index)
      |> App.list_map_to_struct()

    case App.update_product(socket.assigns.product, %{images: images}) do
      {:ok, product} ->
        {
          :noreply,
          socket
          |> assign(:product, product)
          |> put_flash(:info, "Product image updated successfully")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end



  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"id" => id, "category" => category}) do
    socket
    |> assign(:page_title, "Showing part")
    |> assign(:product, App.get_product(id))
    |> assign(:category, category)
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = App.get_product(id)

    return_route =
      if product != nil,
        do:
          PcpbWeb.Router.Helpers.product_show_path(socket, :index, product.part_type, product.id),
        else: PcpbWeb.Router.Helpers.product_index_path(socket, :index)

    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, product)
    |> assign(:category, "edit")
    |> assign(:return_route, return_route)
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
