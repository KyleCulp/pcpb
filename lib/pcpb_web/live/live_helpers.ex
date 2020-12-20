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
    input_opts = [data: opts[:data], class: opts[:class] || "w-full"]
    content_tag :div, [class: "p-2 align-middle w-full col-span-1"] do
      label = label(form, field, humanize(field), [class: "control-label"])
      input = input(type, form, field, input_opts)
      error = PcpbWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  defp input(:text, form, field, input_opts) do
    text_input form, field, input_opts
  end

  defp input(:datepicker, form, field, input_opts) do
    date_input form, field, input_opts
  end

  defp input(:checkbox, form, field, input_opts) do
    checkbox form, field, input_opts
  end

  defp input(:boolean, form, field, input_opts) do
    checkbox form, field, input_opts
  end

  defp input(:number, form, field, input_opts) do
    number_input form, field, input_opts
  end

  defp input(:autocomplete, form, field, opts) do
    list = opts[:data]
    list_name = to_string(field) <> "-datalist"
    input_opts = [class: "w-full", list: list_name]
      input = apply(Phoenix.HTML.Form, :text_input, [form, field, input_opts])
      datalist = content_tag :datalist, [id: list_name] do
        for option <- list do
          content_tag(:option, option)
        end
      end
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end

  def autocomplete_input(form, field, opts \\ []) do
    list = opts[:data]
    list_name = to_string(field) <> "-datalist"
    input_opts = [class: "w-full", list: list_name]
    content_tag :div, [class: "p-2 align-middle w-full col-span-1"] do
      label = label(form, field, humanize(field), [class: "control-label"])
      input = apply(Phoenix.HTML.Form, :text_input, [form, field, input_opts])
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
    list = opts[:data]
    wrapper_opts = [class: "", id: to_string(field) <> "-datalist", "phx-hook": "tag", "phx-update": "ignore", "data-list": list]
    label_opts = [class: "control-label"]
    input_opts = [class: "tag-input", "phx-update": "ignore"]

    field_value = input_value(form, field)
    field_value = if is_list(field_value), do: Enum.join(field_value, ", ")
    input_opts = input_opts
    |> Keyword.put_new(:name, input_name(form, field) <> "[]")
    |> Keyword.put_new(:value, field_value)

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      input = text_input(form, field, input_opts)
      [label, input || ""]
    end
  end

  def map_input(form, field, opts \\ []) do
    inputs = opts[:inputs]
    wrapper_opts = [class: "grid grid-cols-2"]
    label_opts = [class: "control-label text-center col-span-2"]
    input_opts = [class: "tag-input", "phx-update": "ignore"]
    subinput_opts = [class: "w-full", "phx-update": "ignore"]
    subwrapper_opts = [class: "px-2 "]

    field_value = input_value(form, field)
    field_value = if is_list(field_value), do: Enum.join(field_value, ", ")
    input_opts = input_opts
    |> Keyword.put_new(:name, input_name(form, field) <> "[]")
    |> Keyword.put_new(:value, field_value)

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      inputs_for form, field, fn fp ->
        inputsloop = for subfield <- inputs do
          content_tag :div, subwrapper_opts do
            label = label(fp, subfield, humanize(subfield), label_opts)
            input = input(Phoenix.HTML.Form.input_type(fp, subfield), fp, subfield, subinput_opts)
            error = PcpbWeb.ErrorHelpers.error_tag(fp, subfield)
            [label, input, error || ""]
          end
          # input fp, Enum.at(option, 0), [using: Enum.at(option, 1),  classwrapper: "row-span-1 grid-cols-", class: "row-span-1 grid-cols-1"]
        end
      [label, inputsloop || ""]
      end
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
end
