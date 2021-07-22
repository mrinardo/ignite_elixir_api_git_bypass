defmodule ApiGit.Repo do
  use Ecto.Repo,
    otp_app: :api_git,
    adapter: Ecto.Adapters.Postgres
end
