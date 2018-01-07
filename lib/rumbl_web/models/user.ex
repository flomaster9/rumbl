defmodule Rumbl.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :login, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
    end

    def changeset(model, params \\ %{}) do
      model
        |> cast(params, ~w(login email), [])
        |> validate_required([:login, :email])
        |> validate_length(:login, min: 6, max: 20)
    end
end
