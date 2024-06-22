defmodule StudentApp.SchoolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StudentApp.Schools` context.
  """

  @doc """
  Generate a school.
  """
  def school_fixture(attrs \\ %{}) do
    {:ok, school} =
      attrs
      |> Enum.into(%{
        addr: "some addr",
        doe: ~U[2024-06-21 13:41:00Z],
        name: "some name",
        street_addr: "some street_addr"
      })
      |> StudentApp.Schools.create_school()

    school
  end
end
