defmodule PhoawWeb.Plugs.RequireLoginTest do
  use PhoawWeb.ConnCase
  import Plug.Test

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

  test "user is redirected when current_user is not set" do
    conn = build_conn()
    conn
      |> fetch_session
      |> PhoawWeb.Plugs.RequireLogin.call(%{})

    assert redirected_to(conn) == Routes.session_path(conn, :new)
  end

  test "user passes through when current_user is set" do
    conn = build_conn()
    conn
      |> init_test_session(current_user: %User{})
      |> PhoawWeb.Plugs.RequireLogin.call(%{})

    assert conn.status != 302
  end
end
