defmodule ApiGitWeb.ReposController do
  use ApiGitWeb, :controller

  alias ApiGitWeb.FallbackController

  action_fallback FallbackController

  def show(conn, %{"id" => username}) do
    with {:ok, repos_info} <- ApiGit.get_user_repos(username) do
      conn
      |> put_status(:ok)
      |> render("user_repos.json", repos_info: repos_info)
    end
  end
end
