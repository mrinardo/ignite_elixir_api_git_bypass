defmodule ApiGitWeb.FallbackController do
  use ApiGitWeb, :controller

  alias ApiGit.Error
  alias ApiGitWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
