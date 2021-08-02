defmodule ApiGit.Users.CreateTest do
  use ApiGit.DataCase, async: true

  import ApiGit.Factory

  alias ApiGit.{Error, User}
  alias ApiGit.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"senha" => "123456"})

      response = Create.call(params)

      expected_response = %{senha: ["should be at least 8 character(s)"]}

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
