defmodule ApiGitWeb.UsersControllerTest do
  use ApiGitWeb.ConnCase, async: true

  import ApiGit.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{"message" => "User created!", "user" => %{"id" => _id}} = response
    end

    test "when the params are not valid, returns an error", %{conn: conn} do
      params = build(:user_params, %{"senha" => "123456"})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected = %{"message" => %{"senha" => ["should be at least 8 character(s)"]}}

      assert response == expected
    end
  end

  describe "login/2" do
    test "when the credentials are valid, returns a token", %{conn: conn} do
      params = build(:user_params)

      %{"message" => "User created!", "user" => %{"id" => id}} =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      params_login = %{"id" => id, "senha" => params["senha"]}

      response =
        conn
        |> post(Routes.users_path(conn, :login, params_login))
        |> json_response(:ok)

      assert %{"token" => _token} = response
    end

    test "when the user id is invalid, returns an error", %{conn: conn} do
      params_login = %{"id" => "00000000-0000-0000-0000-000000000000", "senha" => "12345678"}

      response =
        conn
        |> post(Routes.users_path(conn, :login, params_login))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found!"}

      assert expected_response == response
    end

    test "when the password is invalid, returns an error", %{conn: conn} do
      params = build(:user_params)

      %{"message" => "User created!", "user" => %{"id" => id}} =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      params_login = %{"id" => id, "senha" => "000000"}

      response =
        conn
        |> post(Routes.users_path(conn, :login, params_login))
        |> json_response(:unauthorized)

      expected_response = %{"message" => "Invalid credentials!"}

      assert expected_response == response
    end
  end
end
