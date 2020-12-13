defmodule PcpbWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  use Phoenix.HTML
  alias Phoenix.HTML.Form

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
  Renders an input form, with label and error support.

  ## Examples

      <%= label form, :colunmn %>
  """
  def input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "p-2 align-middle #{state_class(form, field)}"]
    label_opts = [class: "control-label"]
    input_opts = [class: "p-2 align-middle"]

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      input  = apply(Phoenix.HTML.Form, type, [form, field, input_opts])
      error = PcpbWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  defp state_class(form, field) do
    cond do
      # The form was not yet submitted
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end

  # Implement clauses below for custom inputs.
  @doc """
  Renders an input form, with label and error support.

  ## Examples

      <%= label form, :colunmn %>
  """
  def simple_autocomplete(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)
    list_name = to_string(field) <> "-datalist"
    list = opts[:data]
    wrapper_opts = [class: "p-2 align-middle #{state_class(form, field)}"]
    label_opts = [class: "control-label"]
    input_opts = [class: "p-2 align-middle", list: list_name]
    datalist_opts = [id: list_name]

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      input = apply(Phoenix.HTML.Form, type, [form, field, input_opts])

      datalist = content_tag :datalist, [id: list_name] do
        for option <- list do
          content_tag(:option, option)
        end
      end

      error = PcpbWeb.ErrorHelpers.error_tag(form, field)
      [label, input, datalist, error || ""]
    end
  end

  def tag_input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    list = opts[:data]
    wrapper_opts = [class: "p-2 align-middle max-w-sm", id: to_string(field) <> "-datalist", "phx-hook": "tag", "phx-update": "ignore", "data-list": list]
    label_opts = [class: "control-label"]
    input_opts = [class: "tag-input", "phx-update": "ignore"]

    field_value = input_value(form, field)
    field_value = if is_list(field_value), do: Enum.join(field_value, ", ")
    input_opts = input_opts
    |> Keyword.put_new(:name, input_name(form, field) <> "[]")
    |> Keyword.put_new(:value, field_value)

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      # input = aptply(Phoenix.HTML.Form, type, [form, field, input_opts])
      input = text_input(form, field, input_opts)
      # tagify =


      # error = PcpbWeb.ErrorHelpers.error_tag(form, field)
      [label, input || ""]
    end
  end

  def array_input_value(%{source: source, impl: impl} = form, field)
  when is_atom(field) or is_binary(field) do
try do
  impl.input_value(source, form, field)
rescue
  UndefinedFunctionError ->
    case Map.fetch(form.params, field_to_string(field)) do
      {:ok, value} ->
        value

      :error ->
        Map.get(form.data, field)
    end
end
end


  defp generic_input(type, form, field, opts) when is_list(opts) and (is_atom(field) or is_binary(field)) do
    field_value = input_value(form, field)
    field_value = if is_list(field_value), do: Enum.join(field_value, ", ")
    opts = if opts[:isarray] do
      Keyword.put_new(opts, :name, input_name(form, field) <> "[]")
    else
      Keyword.put_new(opts, :name, input_name(form, field))
    end
    opts =
      opts
      |> Keyword.put_new(:type, type)
      |> Keyword.put_new(:id, input_id(form, field))
      # |> Keyword.put_new(:name, input_name(form, field))
      |> Keyword.put_new(:value, field_value)
      |> Keyword.update!(:value, &maybe_html_escape/1)

    tag(:input, opts)
  end

  defp selected(form, field, opts) do
    {value, opts} = Keyword.pop(opts, :value)
    {selected, opts} = Keyword.pop(opts, :selected)

    if value != nil do
      {value, opts}
    else
      param = field_to_string(field)

      case form do
        %{params: %{^param => sent}} ->
          {sent, opts}

        _ ->
          {selected || input_value(form, field), opts}
      end
    end
  end

  defp field_to_string(field) when is_list(field), do: field |> List.flatten() |> Enum.join(", ")
  defp field_to_string(field) when is_atom(field), do: Atom.to_string(field)
  defp field_to_string(field) when is_binary(field), do: field

  defp maybe_html_escape(nil), do: nil
  defp maybe_html_escape(value), do: html_escape(value)
end
