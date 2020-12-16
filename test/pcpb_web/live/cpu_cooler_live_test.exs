defmodule PcpbWeb.CPUCoolerLiveTest do
  use PcpbWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Pcpb.Parts

  @create_attrs %{bearing_type: "some bearing_type", color: "some color", dimensions: %{}, fan_cfm: "some fan_cfm", fan_size: 42, fans: "some fans", led: "some led", manufacturer: "some manufacturer", model: "some model", model_number: "some model_number", name: "some name", noise_level: "some noise_level", radiator_support: "some radiator_support", release: ~D[2010-04-17], rpm: "some rpm", series: "some series", socket_support: [], type: "some type"}
  @update_attrs %{bearing_type: "some updated bearing_type", color: "some updated color", dimensions: %{}, fan_cfm: "some updated fan_cfm", fan_size: 43, fans: "some updated fans", led: "some updated led", manufacturer: "some updated manufacturer", model: "some updated model", model_number: "some updated model_number", name: "some updated name", noise_level: "some updated noise_level", radiator_support: "some updated radiator_support", release: ~D[2011-05-18], rpm: "some updated rpm", series: "some updated series", socket_support: [], type: "some updated type"}
  @invalid_attrs %{bearing_type: nil, color: nil, dimensions: nil, fan_cfm: nil, fan_size: nil, fans: nil, led: nil, manufacturer: nil, model: nil, model_number: nil, name: nil, noise_level: nil, radiator_support: nil, release: nil, rpm: nil, series: nil, socket_support: nil, type: nil}

  defp fixture(:cpu_cooler) do
    {:ok, cpu_cooler} = Parts.create_cpu_cooler(@create_attrs)
    cpu_cooler
  end

  defp create_cpu_cooler(_) do
    cpu_cooler = fixture(:cpu_cooler)
    %{cpu_cooler: cpu_cooler}
  end

  describe "Index" do
    setup [:create_cpu_cooler]

    test "lists all cpu_coolers", %{conn: conn, cpu_cooler: cpu_cooler} do
      {:ok, _index_live, html} = live(conn, Routes.cpu_cooler_index_path(conn, :index))

      assert html =~ "Listing Cpu coolers"
      assert html =~ cpu_cooler.bearing_type
    end

    test "saves new cpu_cooler", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.cpu_cooler_index_path(conn, :index))

      assert index_live |> element("a", "New Cpu cooler") |> render_click() =~
               "New Cpu cooler"

      assert_patch(index_live, Routes.cpu_cooler_index_path(conn, :new))

      assert index_live
             |> form("#cpu_cooler-form", cpu_cooler: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cpu_cooler-form", cpu_cooler: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cpu_cooler_index_path(conn, :index))

      assert html =~ "Cpu cooler created successfully"
      assert html =~ "some bearing_type"
    end

    test "updates cpu_cooler in listing", %{conn: conn, cpu_cooler: cpu_cooler} do
      {:ok, index_live, _html} = live(conn, Routes.cpu_cooler_index_path(conn, :index))

      assert index_live |> element("#cpu_cooler-#{cpu_cooler.id} a", "Edit") |> render_click() =~
               "Edit Cpu cooler"

      assert_patch(index_live, Routes.cpu_cooler_index_path(conn, :edit, cpu_cooler))

      assert index_live
             |> form("#cpu_cooler-form", cpu_cooler: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cpu_cooler-form", cpu_cooler: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cpu_cooler_index_path(conn, :index))

      assert html =~ "Cpu cooler updated successfully"
      assert html =~ "some updated bearing_type"
    end

    test "deletes cpu_cooler in listing", %{conn: conn, cpu_cooler: cpu_cooler} do
      {:ok, index_live, _html} = live(conn, Routes.cpu_cooler_index_path(conn, :index))

      assert index_live |> element("#cpu_cooler-#{cpu_cooler.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cpu_cooler-#{cpu_cooler.id}")
    end
  end

  describe "Show" do
    setup [:create_cpu_cooler]

    test "displays cpu_cooler", %{conn: conn, cpu_cooler: cpu_cooler} do
      {:ok, _show_live, html} = live(conn, Routes.cpu_cooler_show_path(conn, :show, cpu_cooler))

      assert html =~ "Show Cpu cooler"
      assert html =~ cpu_cooler.bearing_type
    end

    test "updates cpu_cooler within modal", %{conn: conn, cpu_cooler: cpu_cooler} do
      {:ok, show_live, _html} = live(conn, Routes.cpu_cooler_show_path(conn, :show, cpu_cooler))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cpu cooler"

      assert_patch(show_live, Routes.cpu_cooler_show_path(conn, :edit, cpu_cooler))

      assert show_live
             |> form("#cpu_cooler-form", cpu_cooler: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cpu_cooler-form", cpu_cooler: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cpu_cooler_show_path(conn, :show, cpu_cooler))

      assert html =~ "Cpu cooler updated successfully"
      assert html =~ "some updated bearing_type"
    end
  end
end
