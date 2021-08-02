defmodule ApiGit.UserTest do
  use ApiGit.DataCase, async: true

  import ApiGit.Factory

  alias ApiGit.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns changeset for new record" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{senha: "12345678"}, valid?: true} = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = build(:user_params, %{"senha" => "123456"})

      response = User.changeset(params)

      expected_response = %{senha: ["should be at least 8 character(s)"]}

      assert errors_on(response) == expected_response
    end
  end
end
