defmodule StudentApp.StudentsTest do
  use StudentApp.DataCase

  alias StudentApp.Students

  describe "student" do
    alias StudentApp.Students.Student

    import StudentApp.StudentsFixtures

    @invalid_attrs %{name: nil, dob: nil, do_ad: nil}

    test "list_student/0 returns all student" do
      student = student_fixture()
      assert Students.list_student() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      valid_attrs = %{name: "some name", dob: ~U[2024-06-21 13:15:00Z], do_ad: ~U[2024-06-21 13:15:00Z]}

      assert {:ok, %Student{} = student} = Students.create_student(valid_attrs)
      assert student.name == "some name"
      assert student.dob == ~U[2024-06-21 13:15:00Z]
      assert student.do_ad == ~U[2024-06-21 13:15:00Z]
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{name: "some updated name", dob: ~U[2024-06-22 13:15:00Z], do_ad: ~U[2024-06-22 13:15:00Z]}

      assert {:ok, %Student{} = student} = Students.update_student(student, update_attrs)
      assert student.name == "some updated name"
      assert student.dob == ~U[2024-06-22 13:15:00Z]
      assert student.do_ad == ~U[2024-06-22 13:15:00Z]
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end
