defmodule Rumbl.Repo do
  # use Ecto.Repo, otp_app: :rumbl

  # @doc """
  # Dynamically loads the repository url from the
  # DATABASE_URL environment variable.
  # """

  # def init(_, opts) do
  #   {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  # end

  def start_link do
    {:ok, self()}
  end

  alias Rumbl.User

  def all(User) do
    [
      %User{email: "kate_j@gmail.com", id: "1", login: "kate", password: "kate_pass"},
      %User{email: "admin_h@gmail.com", id: "2", login: "myadm", password: "adm_pass"},
      %User{email: "william_l@gmail.com", id: "3", login: "willi_am", password: "will_pass"}
    ]
  end

  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn user -> user.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn user ->
      Enum.all? params, fn {key, value} -> Map.get(user, key) == value end
    end
  end

end