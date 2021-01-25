defmodule PcpbWeb.ProductLive.FormComponent do
  use PcpbWeb, :live_component

  alias Pcpb.App
  alias Pcpb.App.Product

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = App.change_product(product)
    # provides list of all parts that fit the current product type, handling for if the product exists already
    parts = get_parts(product.part_type)
    # provides list of all parts types
    part_types = Pcpb.Parts.Part.part_types()

    socket =
      socket
      |> assign(assigns)
      |> assign(:changeset, changeset)
      |> assign(:parts, parts)
      |> assign(:part_types, part_types)
      |> allow_upload(:photo, accept: ~w(.png .jpg .jpeg), max_entries: 20)

    {:ok, socket}
  end

  defp get_parts(part_type) do
    if part_type,
      do: Pcpb.Parts.list_part_ids(part_type),
      # CPU is the first part type, so only show :cpu ids
      else: Pcpb.Parts.list_part_ids(:cpu)
  end


  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    part_type = Map.get(product_params, "part_type")
    parts = Pcpb.Parts.list_part_ids(part_type)

    changeset =
      socket.assigns.product
      |> App.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, socket
      |> assign(:changeset, changeset)
      |> assign(:parts, parts)
  }
  end

  def handle_event("part_change", %{"part_type" => part_type}, socket) do
    part_types = Pcpb.Parts.Part.part_types()
      |> Enum.filter(fn x -> x == part_type end)
    IO.inspect(part_types)
    update(socket, :part_types, fn count -> count + 1 end)
    # save_product(socket, socket.assigns.action, product_params)
  end

  def handle_event("imagechange", %{"images" => images}, socket) do
    IO.inspect(images)
    # socket =
    {:noreply, socket}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  def handle_event("cancel-entry", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :photo, ref)}
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

  defp save_product(socket, :edit, product_params) do
    images = consume_s3_photos(socket, product_params, socket.assigns.product.images)
    case App.update_product(socket.assigns.product, product_params, images) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    product_params = consume_s3_photos(socket, product_params, [])
    case App.create_product(%Product{}, product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)

        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp ext(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    ext
  end

  defp put_photo_urls(socket, %Product{} = product) do
    {completed, []} = uploaded_entries(socket, :photo)

    urls =
      for entry <- completed do
        %{id: entry.uuid, full: Routes.static_path(socket, "/#{entry.uuid}.#{ext(entry)}")}
      end
    Map.merge(product, %{images: product.images ++ urls})
    # %Product{product | images: urls}
  end

  defp consume_photos(socket, %Product{} = product) do
    consume_uploaded_entries(socket, :photo, fn meta, entry ->
      dest = Path.join("priv/static/uploads", "#{entry.uuid}.#{ext(entry)}")
      File.cp!(meta.path, dest)
    end)

    {:ok, product}
  end

  import SweetXml
  defp consume_s3_photos(socket, product_params, images) do
    new_images = consume_uploaded_entries(socket, :photo, fn meta, entry ->
      full_url = meta.path
      |> ExAws.S3.Upload.stream_file()
      |> ExAws.S3.upload("parts", "/#{entry.uuid}.#{ext(entry)}")
      |> ExAws.request! #=> :done
      |> Map.get(:body)
      |> xpath(~x"//Key/text()")
      |> to_string()

      meta.path
      |> Thumbnex.create_thumbnail("priv/static/uploads/#{entry.uuid}.#{ext(entry)}", max_width: 256, max_height: 256)
      |> IO.inspect()
      thumbnail_url = "priv/static/uploads/#{entry.uuid}.#{ext(entry)}"
      |> ExAws.S3.Upload.stream_file()
      |> ExAws.S3.upload("parts", "/#{entry.uuid}.thumbnail.#{ext(entry)}")
      |> ExAws.request! #=> :done
      |> Map.get(:body)
      |> xpath(~x"//Key/text()")
      |> to_string()

      %{id: entry.uuid, full: full_url, thumbnail: thumbnail_url}

    end)

    images = images ++ new_images

    # product_params = Map.merge(product_params, %{images: images})
    # product_params = for {k, v} <- product_params, do: {to_string(k), v}, into: %{}
    # IO.inspect(product_params)
  end
end
