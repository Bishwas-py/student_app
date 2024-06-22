defmodule StudentApp.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:student) do
      add :name, :string
      add :dob, :utc_datetime
      add :do_ad, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
