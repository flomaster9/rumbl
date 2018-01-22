defmodule Rumbl.Category do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "categories" do
    field :name, :string

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name), [])
  end

  def name_and_ids(query) do
    from c in query, select: {c.name, c.id}
  end

  def alphabetical(query) do
    from c in query, order_by: c.name
  end
end