defmodule StudentApp.Schools.School do
  use Ecto.Schema
  import Ecto.Changeset

  schema "school" do
    field :name, :string
    field :addr, :string
    field :doe, :utc_datetime
    field :street_addr, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:name, :doe, :addr, :street_addr])
    |> validate_required([:name, :doe, :addr, :street_addr])
  end
end
