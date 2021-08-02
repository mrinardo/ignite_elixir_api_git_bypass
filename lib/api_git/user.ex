defmodule ApiGit.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:senha]

  @derive {Jason.Encoder, only: [:id]}

  schema "users" do
    field :senha, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:senha, min: 8)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{senha: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
