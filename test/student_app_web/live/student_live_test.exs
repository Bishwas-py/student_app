defmodule StudentAppWeb.StudentLiveTest do
  use StudentAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import StudentApp.StudentsFixtures

  @create_attrs %{name: "some name", dob: "2024-06-21T13:15:00Z", do_ad: "2024-06-21T13:15:00Z"}
  @update_attrs %{name: "some updated name", dob: "2024-06-22T13:15:00Z", do_ad: "2024-06-22T13:15:00Z"}
  @invalid_attrs %{name: nil, dob: nil, do_ad: nil}

  defp create_student(_) do
    student = student_fixture()
    %{student: student}
  end

  describe "Index" do
    setup [:create_student]

    test "lists all student", %{conn: conn, student: student} do
      {:ok, _index_live, html} = live(conn, ~p"/student")

      assert html =~ "Listing Student"
      assert html =~ student.name
    end

    test "saves new student", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/student")

      assert index_live |> element("a", "New Student") |> render_click() =~
               "New Student"

      assert_patch(index_live, ~p"/student/new")

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student-form", student: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/student")

      html = render(index_live)
      assert html =~ "Student created successfully"
      assert html =~ "some name"
    end

    test "updates student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/student")

      assert index_live |> element("#student-#{student.id} a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(index_live, ~p"/student/#{student}/edit")

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student-form", student: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/student")

      html = render(index_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/student")

      assert index_live |> element("#student-#{student.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#student-#{student.id}")
    end
  end

  describe "Show" do
    setup [:create_student]

    test "displays student", %{conn: conn, student: student} do
      {:ok, _show_live, html} = live(conn, ~p"/student/#{student}")

      assert html =~ "Show Student"
      assert html =~ student.name
    end

    test "updates student within modal", %{conn: conn, student: student} do
      {:ok, show_live, _html} = live(conn, ~p"/student/#{student}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(show_live, ~p"/student/#{student}/show/edit")

      assert show_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#student-form", student: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/student/#{student}")

      html = render(show_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated name"
    end
  end
end
