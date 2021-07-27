defmodule ApiGit.Client.ClientTest do
  use ExUnit.Case, async: true

  import ApiGit.Factory

  alias ApiGit.Client.Client
  alias ApiGit.Error
  alias Plug.Conn

  describe "get_user_repos/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when the username is valid, returns user's repos", %{bypass: bypass} do
      username = "mrinardo"

      url = endpoint_url(bypass.port)

      body_response = build(:user_repos_response)

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body_response)
      end)

      response = Client.get_user_repos(url, username)

      expected_response =
        {:ok,
         [
           %{
             "description" =>
               "Exemplo de aplicação de quiz com React e Next.js feito durante Imersão React da Alura",
             "html_url" => "https://github.com/mrinardo/beatlesquiz",
             "id" => 332_934_215,
             "name" => "beatlesquiz",
             "stargazers_count" => 0
           },
           %{
             "description" => "Challenge #1 Ignite Elixir module 6: Api GitHub Phoenix app",
             "html_url" => "https://github.com/mrinardo/ignite_elixir_api_git",
             "id" => 388_448_069,
             "name" => "ignite_elixir_api_git",
             "stargazers_count" => 0
           }
         ]}

      assert expected_response == response
    end

    test "when the username is not found, returns an error", %{bypass: bypass} do
      username = "mrinardoxxx"

      url = endpoint_url(bypass.port)

      body_response = ~s({
        "message": "Not Found",
        "documentation_url": "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      })

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body_response)
      end)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, Error.build_user_not_found_error()}

      assert expected_response == response
    end

    test "when there is a generic server error, returns an error", %{bypass: bypass} do
      username = "mrinardo"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_user_repos(url, username)

      assert {:error, %Error{result: _reason, status: :bad_request}} = response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
