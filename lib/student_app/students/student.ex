defmodule StudentApp.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "student" do
    field :name, :string
    field :dob, :utc_datetime
    field :do_ad, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :dob, :do_ad])
    |> validate_required([:name, :dob, :do_ad])
  end
end
