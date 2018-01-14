defmodule Rumbl.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Rumbl.User

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(url title description), ~w())
  end
end