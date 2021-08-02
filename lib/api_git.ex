defmodule ApiGit do
  alias ApiGit.Github.GetRepos, as: UserReposGet
  alias ApiGit.Users.Create, as: UserCreate

  defdelegate get_user_repos(username), to: UserReposGet, as: :call

  defdelegate create_user(params), to: UserCreate, as: :call
end
