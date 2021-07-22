defmodule ApiGit.Client.Client do
  use Tesla

  alias ApiGit.Client.Parser
  alias ApiGit.Error
  alias Tesla.Env

  @base_url "https://api.github.com/users/"

  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  def get_user_repos(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_get_user_repos()
  end

  defp handle_get_user_repos({:ok, %Env{status: 200, body: body}}) do
    repos = Parser.parse_user_repos_content(body)

    {:ok, repos}
  end

  defp handle_get_user_repos({:ok, return}) do
    case return do
      %Env{status: 404, body: %{"message" => "Not Found"}} ->
        {:error, Error.build_user_not_found_error()}

      %Env{status: _status, body: reason} ->
        {:error, Error.build(:bad_request, reason)}
    end
  end

  defp handle_get_user_repos({:error, reason}), do: {:error, Error.build(:bad_request, reason)}
end
