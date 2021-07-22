defmodule ApiGit.Client.Parser do
  alias ApiGit.Error

  def parse_user_repos_content(content) when not is_list(content) do
    {:error, Error.build(:bad_request, "Invalid content for parsing!")}
  end

  def parse_user_repos_content(content) do
    content
    |> Enum.map(&parse_user_repos_item/1)
  end

  defp parse_user_repos_item(%{
         "id" => id,
         "name" => name,
         "description" => description,
         "html_url" => html_url,
         "stargazers_count" => stargazers_count
       }) do
    %{
      "id" => id,
      "name" => name,
      "description" => description,
      "html_url" => html_url,
      "stargazers_count" => stargazers_count
    }
  end
end
