defmodule ApiGitWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :api_git

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
