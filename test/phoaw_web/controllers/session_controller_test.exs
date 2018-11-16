defmodule PhoawWeb.SessionControllerTest do
  use PhoawWeb.ConnCase

  alias Phoaw.Contents.User
  alias Phoaw.Repo

  setup do
    valid_params = %{
      username: 'test',
      password: 'test1234',
      password_confirmation: 'test1234',
      email: 'test@example.com'
    }

    %User{}
    |> User.changeset(valid_params)
    |> Repo.insert()

    {:ok, conn: build_conn()}
  end

  test "shows the login form", %{conn: conn} do
    conn = get(conn, Routes.session_path(conn, :new))
    assert html_response(conn, 200) =~ "Login"
  end

  describe "/create" do
    test "when success to login, it creates new session for logged in user", %{conn: conn} do
      conn =
        post conn,
             conn
             |> Routes.session_path(:create),
             user: %{username: "test", password: "test1234"}

      assert get_session(conn, :current_user)
      assert get_flash(conn, :info) == "Successfully signed in"
      assert redirected_to(conn) == Routes.session_path(conn, :index)
    end

    test "when failed to login, it does not create a session", %{conn: conn} do
      conn =
        post conn,
             conn
             |> Routes.session_path(:create),
             user: %{username: "test", password: "wrong"}

      refute get_session(conn, :current_user)
      assert get_flash(conn, :error) == "Invalid username or password"
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end

    test "when user dose not exits, it does not create a session", %{conn: conn} do
      conn =
        post conn,
             conn
             |> Routes.session_path(:create),
             user: %{username: "foo", password: "wrong"}

      assert get_flash(conn, :error) == "Invalid username or password"
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end
end
