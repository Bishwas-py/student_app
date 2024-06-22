defmodule StudentApp.Repo do
  use Ecto.Repo,
    otp_app: :student_app,
    adapter: Ecto.Adapters.Postgres
end
