defmodule StudentAppWeb.SchoolLiveTest do
  use StudentAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import StudentApp.SchoolsFixtures

  @create_attrs %{name: "some name", addr: "some addr", doe: "2024-06-21T13:41:00Z", street_addr: "some street_addr"}
  @update_attrs %{name: "some updated name", addr: "some updated addr", doe: "2024-06-22T13:41:00Z", street_addr: "some updated street_addr"}
  @invalid_attrs %{name: nil, addr: nil, doe: nil, street_addr: nil}

  defp create_school(_) do
    school = school_fixture()
    %{school: school}
  end

  describe "Index" do
    setup [:create_school]

    test "lists all school", %{conn: conn, school: school} do
      {:ok, _index_live, html} = live(conn, ~p"/school")

      assert html =~ "Listing School"
      assert html =~ school.name
    end

    test "saves new school", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/school")

      assert index_live |> element("a", "New School") |> render_click() =~
               "New School"

      assert_patch(index_live, ~p"/school/new")

      assert index_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#school-form", school: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/school")

      html = render(index_live)
      assert html =~ "School created successfully"
      assert html =~ "some name"
    end

    test "updates school in listing", %{conn: conn, school: school} do
      {:ok, index_live, _html} = live(conn, ~p"/school")

      assert index_live |> element("#school-#{school.id} a", "Edit") |> render_click() =~
               "Edit School"

      assert_patch(index_live, ~p"/school/#{school}/edit")

      assert index_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#school-form", school: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/school")

      html = render(index_live)
      assert html =~ "School updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes school in listing", %{conn: conn, school: school} do
      {:ok, index_live, _html} = live(conn, ~p"/school")

      assert index_live |> element("#school-#{school.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#school-#{school.id}")
    end
  end

  describe "Show" do
    setup [:create_school]

    test "displays school", %{conn: conn, school: school} do
      {:ok, _show_live, html} = live(conn, ~p"/school/#{school}")

      assert html =~ "Show School"
      assert html =~ school.name
    end

    test "updates school within modal", %{conn: conn, school: school} do
      {:ok, show_live, _html} = live(conn, ~p"/school/#{school}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit School"

      assert_patch(show_live, ~p"/school/#{school}/show/edit")

      assert show_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#school-form", school: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/school/#{school}")

      html = render(show_live)
      assert html =~ "School updated successfully"
      assert html =~ "some updated name"
    end
  end
end
