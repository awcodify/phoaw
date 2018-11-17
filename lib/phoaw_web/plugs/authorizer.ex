defmodule PhoawWeb.Plugs.Authorizer do
  import Plug.Conn
  use PhoawWeb, :controller

  def init(default), do: default

  def call(conn, _default) do
    current_user = get_session(conn, :current_user)
    if current_user == nil do

      conn
        |> put_flash(:info, "You should log in first.")
        |> redirect(to: Routes.session_path(conn, :new))
    end
    conn
  end
end