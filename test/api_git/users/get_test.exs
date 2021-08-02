defmodule ApiGit.Users.GetTest do
  use ApiGit.DataCase, async: true

  import ApiGit.Factory

  alias ApiGit.{Error, User}
  alias ApiGit.Users.Get

  describe "by_id/1" do
    test "when the user id is found, returns the user" do
      user = build(:user)

      insert(user)

      response = Get.by_id(user.id)

      assert {:ok, %User{}} = response
    end

    test "when the user id is not found, returns an error" do
      response = Get.by_id("00000000-0000-0000-0000-000000000000")

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
