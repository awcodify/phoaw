defmodule PhoawWeb.SessionControllerTest do
  use PhoawWeb.ConnCase

  alias Phoaw.Contents

  @create_attrs %{
    email: "test@example.com",
    password: "test1234",
    password_confirmation: "test1234",
    username: "example"
  }
  @login_attrs %{
    username: "example",
    password: "test1234"
  }
  @invalid_attrs %{username: "", password: ""}

  setup do
    {:ok, user} = Contents.create_user(@create_attrs)
    {:ok, conn: build_conn(), user: user}
  end

  describe "new session" do
    test "render form login", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200) =~ "Login"
    end
  end

  describe "create session login" do
    test "redirects to user list when login successful", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @login_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :index)

      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end

    test "renders errors when login failed", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @invalid_attrs)
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end

  describe "Log out user" do
    test "redirects to home page when logout successful", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @login_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :index)

      conn = post(conn, Routes.session_path(conn, :logout))
      assert conn.status == 302
      assert redirected_to(conn) == "/"
    end
  end
end