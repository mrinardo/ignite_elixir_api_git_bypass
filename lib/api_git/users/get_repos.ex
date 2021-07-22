defmodule ApiGit.Users.GetRepos do
  alias ApiGit.Client.Client

  def call(username) do
    Client.get_user_repos(username)
  end
end
