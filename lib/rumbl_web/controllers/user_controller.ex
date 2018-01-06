defmodule RumblWeb.UserController do
  use RumblWeb, :controller
  alias Rumbl.Repo
  alias Rumbl.User

  def index(conn, _) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.html", user: user)
  end
end