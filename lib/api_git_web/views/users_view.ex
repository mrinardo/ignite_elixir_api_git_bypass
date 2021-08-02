defmodule ApiGitWeb.UsersView do
  use ApiGitWeb, :view

  alias ApiGit.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created!",
      user: user
    }
  end

  def render("login.json", %{token: token}) do
    %{
      token: token
    }
  end
end
