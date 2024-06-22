defmodule StudentApp.Repo.Migrations.AddStateToSchools do
  use Ecto.Migration

  def change do
    create table(:state) do
      add :name, :string
      add :abbreviation, :string
      add :population, :integer
      add :capital, :string
      add :largest_city, :string
      add :statehood_date, :utc_datetime

      timestamps(type: :utc_datetime)
    end
    alter table(:school) do
      add :state_id, references(:state, on_delete: :nothing)
    end
  end
end
