defmodule PhoawWeb.SessionController do
  use PhoawWeb, :controller

  alias Phoaw.Contents
  alias Phoaw.Contents.User
  alias Phoaw.Auth.Auth
  alias Phoaw.Auth.Guardian

  def new(conn, _params) do
    changeset = Contents.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => session_params}) do
    authenticated = Auth.authenticate_user(session_params["username"], session_params["password"])
    authenticated |> login_reply(conn)
  end

  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: Routes.session_path(conn, :new))
  end
  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.user_path(conn, :index))
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end
end
