defmodule ApiGitWeb.ReposView do
  use ApiGitWeb, :view

  def render("user_repos.json", %{repos_info: repos}), do: %{repos: repos}
end
