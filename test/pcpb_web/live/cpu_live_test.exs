defmodule PcpbWeb.CPULiveTest do
  use PcpbWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Pcpb.Parts

  @create_attrs %{boost_clock: 42, boost_tdp: 42, cache: "some cache", core_clock: 42, core_count: 42, family: "some family", integrated_graphics: "some integrated_graphics", lithography: "some lithography", manufacturer: "some manufacturer", max_memory: 42, memory_channels: 42, model: "some model", model_year: "some model_year", name: "some name", series: "some series", smt: "some smt", stock_cooler: "some stock_cooler", tdp: 42}
  @update_attrs %{boost_clock: 43, boost_tdp: 43, cache: "some updated cache", core_clock: 43, core_count: 43, family: "some updated family", integrated_graphics: "some updated integrated_graphics", lithography: "some updated lithography", manufacturer: "some updated manufacturer", max_memory: 43, memory_channels: 43, model: "some updated model", model_year: "some updated model_year", name: "some updated name", series: "some updated series", smt: "some updated smt", stock_cooler: "some updated stock_cooler", tdp: 43}
  @invalid_attrs %{boost_clock: nil, boost_tdp: nil, cache: nil, core_clock: nil, core_count: nil, family: nil, integrated_graphics: nil, lithography: nil, manufacturer: nil, max_memory: nil, memory_channels: nil, model: nil, model_year: nil, name: nil, series: nil, smt: nil, stock_cooler: nil, tdp: nil}

  defp fixture(:cpu) do
    {:ok, cpu} = Parts.create_cpu(@create_attrs)
    cpu
  end

  defp create_cpu(_) do
    cpu = fixture(:cpu)
    %{cpu: cpu}
  end

  describe "Index" do
    setup [:create_cpu]

    test "lists all cpus", %{conn: conn, cpu: cpu} do
      {:ok, _index_live, html} = live(conn, Routes.cpu_index_path(conn, :index))

      assert html =~ "Listing Cpus"
      assert html =~ cpu.cache
    end

    test "saves new cpu", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.cpu_index_path(conn, :index))

      assert index_live |> element("a", "New Cpu") |> render_click() =~
               "New Cpu"

      assert_patch(index_live, Routes.cpu_index_path(conn, :new))

      assert index_live
             |> form("#cpu-form", cpu: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cpu-form", cpu: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cpu_index_path(conn, :index))

      assert html =~ "Cpu created successfully"
      assert html =~ "some cache"
    end

    test "updates cpu in listing", %{conn: conn, cpu: cpu} do
      {:ok, index_live, _html} = live(conn, Routes.cpu_index_path(conn, :index))

      assert index_live |> element("#cpu-#{cpu.id} a", "Edit") |> render_click() =~
               "Edit Cpu"

      assert_patch(index_live, Routes.cpu_index_path(conn, :edit, cpu))

      assert index_live
             |> form("#cpu-form", cpu: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cpu-form", cpu: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cpu_index_path(conn, :index))

      assert html =~ "Cpu updated successfully"
      assert html =~ "some updated cache"
    end

    test "deletes cpu in listing", %{conn: conn, cpu: cpu} do
      {:ok, index_live, _html} = live(conn, Routes.cpu_index_path(conn, :index))

      assert index_live |> element("#cpu-#{cpu.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cpu-#{cpu.id}")
    end
  end

  describe "Show" do
    setup [:create_cpu]

    test "displays cpu", %{conn: conn, cpu: cpu} do
      {:ok, _show_live, html} = live(conn, Routes.cpu_show_path(conn, :show, cpu))

      assert html =~ "Show Cpu"
      assert html =~ cpu.cache
    end

    test "updates cpu within modal", %{conn: conn, cpu: cpu} do
      {:ok, show_live, _html} = live(conn, Routes.cpu_show_path(conn, :show, cpu))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cpu"

      assert_patch(show_live, Routes.cpu_show_path(conn, :edit, cpu))

      assert show_live
             |> form("#cpu-form", cpu: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cpu-form", cpu: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cpu_show_path(conn, :show, cpu))

      assert html =~ "Cpu updated successfully"
      assert html =~ "some updated cache"
    end
  end
end
