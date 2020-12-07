defmodule PcpbWeb.CaseLiveTest do
  use PcpbWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Pcpb.Parts

  @create_attrs %{
    clearance: %{},
    color: "some color",
    dimensions: %{},
    dust_filters: %{},
    expansion_slots: %{},
    fan_options: %{},
    included_psu: "some included_psu",
    io: %{},
    manufacturer: "some manufacturer",
    model: "some model",
    model_number: "some model_number",
    motherboard_support: [],
    name: "some name",
    psu_mount_location: "some psu_mount_location",
    psu_shroud: "some psu_shroud",
    psu_support: [],
    radiator_support: %{},
    release: ~D[2010-04-17],
    type: "some type",
    weight: "120.5",
    windows: %{}
  }
  @update_attrs %{
    clearance: %{},
    color: "some updated color",
    dimensions: %{},
    dust_filters: %{},
    expansion_slots: %{},
    fan_options: %{},
    included_psu: "some updated included_psu",
    io: %{},
    manufacturer: "some updated manufacturer",
    model: "some updated model",
    model_number: "some updated model_number",
    motherboard_support: [],
    name: "some updated name",
    psu_mount_location: "some updated psu_mount_location",
    psu_shroud: "some updated psu_shroud",
    psu_support: [],
    radiator_support: %{},
    release: ~D[2011-05-18],
    type: "some updated type",
    weight: "456.7",
    windows: %{}
  }
  @invalid_attrs %{
    clearance: nil,
    color: nil,
    dimensions: nil,
    dust_filters: nil,
    expansion_slots: nil,
    fan_options: nil,
    included_psu: nil,
    io: nil,
    manufacturer: nil,
    model: nil,
    model_number: nil,
    motherboard_support: nil,
    name: nil,
    psu_mount_location: nil,
    psu_shroud: nil,
    psu_support: nil,
    radiator_support: nil,
    release: nil,
    type: nil,
    weight: nil,
    windows: nil
  }

  defp fixture(:case) do
    {:ok, case} = Parts.create_case(@create_attrs)
    case
  end

  defp create_case(_) do
    case = fixture(:case)
    %{case: case}
  end

  describe "Index" do
    setup [:create_case]

    test "lists all cases", %{conn: conn, case: case} do
      {:ok, _index_live, html} = live(conn, Routes.case_index_path(conn, :index))

      assert html =~ "Listing Cases"
      assert html =~ case.color
    end

    test "saves new case", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.case_index_path(conn, :index))

      assert index_live |> element("a", "New Case") |> render_click() =~
               "New Case"

      assert_patch(index_live, Routes.case_index_path(conn, :new))

      assert index_live
             |> form("#case-form", case: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#case-form", case: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.case_index_path(conn, :index))

      assert html =~ "Case created successfully"
      assert html =~ "some color"
    end

    test "updates case in listing", %{conn: conn, case: case} do
      {:ok, index_live, _html} = live(conn, Routes.case_index_path(conn, :index))

      assert index_live |> element("#case-#{case.id} a", "Edit") |> render_click() =~
               "Edit Case"

      assert_patch(index_live, Routes.case_index_path(conn, :edit, case))

      assert index_live
             |> form("#case-form", case: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#case-form", case: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.case_index_path(conn, :index))

      assert html =~ "Case updated successfully"
      assert html =~ "some updated color"
    end

    test "deletes case in listing", %{conn: conn, case: case} do
      {:ok, index_live, _html} = live(conn, Routes.case_index_path(conn, :index))

      assert index_live |> element("#case-#{case.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#case-#{case.id}")
    end
  end

  describe "Show" do
    setup [:create_case]

    test "displays case", %{conn: conn, case: case} do
      {:ok, _show_live, html} = live(conn, Routes.case_show_path(conn, :show, case))

      assert html =~ "Show Case"
      assert html =~ case.color
    end

    test "updates case within modal", %{conn: conn, case: case} do
      {:ok, show_live, _html} = live(conn, Routes.case_show_path(conn, :show, case))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Case"

      assert_patch(show_live, Routes.case_show_path(conn, :edit, case))

      assert show_live
             |> form("#case-form", case: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#case-form", case: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.case_show_path(conn, :show, case))

      assert html =~ "Case updated successfully"
      assert html =~ "some updated color"
    end
  end
end
