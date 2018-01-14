defmodule RumblWeb.VideoController do
  use RumblWeb, :controller
  alias Rumbl.Repo
  alias Rumbl.Video

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
                [conn, conn.params, conn.assigns.current_user])
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:videos)
      |> Video.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, user) do
    changeset =
      user
      |> build_assoc(:videos)
      |> Video.changeset(video_params)
    case Repo.insert(changeset) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "video #{video.title} was created!")
        |> redirect(to: video_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _params, user) do
    query = Ecto.assoc(user, :videos)
    videos = Repo.all(query)
    render(conn, "index.html", videos: videos)
  end

  def show(conn, %{"id" => id}, user) do
    video = Repo.get(Video, id)
    render(conn, "show.html", video: video)
  end

  def delete(conn, %{"id" => id}, user) do
    video = Repo.get(Video, id)
    Repo.delete!(video)
    conn
    |> put_flash(:info, "video #{video.title} was deleted")
    |> redirect(to: video_path(conn, :index))
  end
end