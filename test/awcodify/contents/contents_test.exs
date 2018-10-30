defmodule Awcodify.ContentsTest do
  use Awcodify.DataCase

  alias Awcodify.Contents

  describe "posts" do
    alias Awcodify.Contents.Post

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Contents.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Contents.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Contents.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Contents.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contents.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Contents.update_post(post, @update_attrs)

      assert post.body == "some updated body"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Contents.update_post(post, @invalid_attrs)
      assert post == Contents.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Contents.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Contents.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Contents.change_post(post)
    end
  end

  describe "users" do
    alias Awcodify.Contents.User

    @valid_attrs %{
      email: "some email",
      password: "examplepassword",
      password_confirmation: "examplepassword",
      username: "some username"
    }
    @update_attrs %{
      email: "some updated email",
      password: "updatedpassword",
      password_confirmation: "updatedpassword",
      username: "some updated username"
    }
    @invalid_attrs %{email: nil, password_digest: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Contents.create_user()

      user = %{user | password: nil, password_confirmation: nil}
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Contents.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Contents.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Contents.create_user(@valid_attrs)
      assert user.email == "some email"
      assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, user.password_digest)
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contents.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Contents.update_user(user, @update_attrs)

      assert user.email == "some updated email"
      assert Comeonin.Bcrypt.checkpw(@update_attrs.password, user.password_digest)
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Contents.update_user(user, @invalid_attrs)
      assert user == Contents.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Contents.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Contents.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Contents.change_user(user)
    end
  end
end
