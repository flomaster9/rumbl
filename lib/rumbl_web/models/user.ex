defmodule Rumbl.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :login, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Video

    timestamps()
    end

    def changeset(model, params \\ %{}) do
      model
      |> cast(params, ~w(login email), [])
      |> validate_required([:login, :email])
      |> validate_length(:login, min: 6, max: 20)
    end

    def registration_changeset(model, params) do
      model
      |> changeset(params)
      |> cast(params, ~w(password), [])
      |> validate_length(:password, min: 6, max: 100)
      |> put_pass_hash()
    end

    defp put_pass_hash(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
        _ -> changeset
      end
    end
end
