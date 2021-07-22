defmodule ApiGit do
  alias ApiGit.Users.GetRepos, as: UserReposGet

  defdelegate get_user_repos(username), to: UserReposGet, as: :call
end
