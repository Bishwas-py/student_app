defmodule StudentApp.Repo.Migrations.CreateSchool do
  use Ecto.Migration

  def change do
    create table(:school) do
      add :name, :string
      add :doe, :utc_datetime
      add :addr, :string
      add :street_addr, :string

      timestamps(type: :utc_datetime)
    end
  end
end
