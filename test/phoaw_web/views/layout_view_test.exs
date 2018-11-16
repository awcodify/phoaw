defmodule PhoawWeb.LayoutViewTest do
  use PhoawWeb.ConnCase, async: true

  alias PhoawWeb.LayoutView
  alias Phoaw.Contents.User
  alias Phoaw.Repo

  setup do
    valid_params = %{
      username: "test",
      password: "test1234",
      password_confirmation: "test1234",
      email: "test@example.com"
    }

    %User{}
    |> User.changeset(valid_params)
    |> Repo.insert()

    {:ok, conn: build_conn()}
  end

  test "current user returns the user in the session", %{conn: conn} do
    conn =
      post conn,
           conn
           |> Routes.session_path(:create),
           user: %{username: "test", password: "test1234"}

    assert LayoutView.current_user(conn)
  end

  test "when user session is not found, current user returns nothing", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})

    conn =
      conn
      |> delete(Routes.session_path(conn, :delete, user))

    refute LayoutView.current_user(conn)
  end
end
