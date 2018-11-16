defmodule PhoawWeb.SessionController do
  use PhoawWeb, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias Phoaw.Contents.User
  alias Phoaw.Repo

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    User
    |> Repo.get_by(username: user_params["username"])
    |> sign_in(user_params["password"], conn)
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Successfully signed out")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.changeset(%User{}))
  end

  defp failed_to_sign_in(conn) do
    conn
    |> put_flash(:error, failed_to_sign_in_message())
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp failed_to_sign_in_message do
    "Invalid username or password"
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    failed_to_sign_in(conn)
  end

  defp sign_in(user, password, conn) do
    if checkpw(password, user.password_digest) do
      conn
      |> Plug.Conn.put_session(:current_user, %{id: user.id, username: user.username})
      |> put_flash(:info, "Successfully signed in")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      failed_to_sign_in(conn)
    end
  end
end
