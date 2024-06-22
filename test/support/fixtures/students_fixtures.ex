defmodule StudentApp.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StudentApp.Students` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        do_ad: ~U[2024-06-21 13:15:00Z],
        dob: ~U[2024-06-21 13:15:00Z],
        name: "some name"
      })
      |> StudentApp.Students.create_student()

    student
  end
end
