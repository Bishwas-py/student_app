defmodule StudentApp.SchoolsTest do
  use StudentApp.DataCase

  alias StudentApp.Schools

  describe "school" do
    alias StudentApp.Schools.School

    import StudentApp.SchoolsFixtures

    @invalid_attrs %{name: nil, addr: nil, doe: nil, street_addr: nil}

    test "list_school/0 returns all school" do
      school = school_fixture()
      assert Schools.list_school() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Schools.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      valid_attrs = %{name: "some name", addr: "some addr", doe: ~U[2024-06-21 13:41:00Z], street_addr: "some street_addr"}

      assert {:ok, %School{} = school} = Schools.create_school(valid_attrs)
      assert school.name == "some name"
      assert school.addr == "some addr"
      assert school.doe == ~U[2024-06-21 13:41:00Z]
      assert school.street_addr == "some street_addr"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schools.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      update_attrs = %{name: "some updated name", addr: "some updated addr", doe: ~U[2024-06-22 13:41:00Z], street_addr: "some updated street_addr"}

      assert {:ok, %School{} = school} = Schools.update_school(school, update_attrs)
      assert school.name == "some updated name"
      assert school.addr == "some updated addr"
      assert school.doe == ~U[2024-06-22 13:41:00Z]
      assert school.street_addr == "some updated street_addr"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Schools.update_school(school, @invalid_attrs)
      assert school == Schools.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Schools.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Schools.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Schools.change_school(school)
    end
  end
end
