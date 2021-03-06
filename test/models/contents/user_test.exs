defmodule Phoaw.Contents.UserTest do
  use Phoaw.DataCase

  alias Phoaw.Contents.User

  @valid_attrs %{
    email: "test@example.com",
    password: "test1234",
    password_confirmation: "test1234",
    username: "example"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)

    # password_digest value gets set to a hash
    assert Comeonin.Bcrypt.checkpw(
             @valid_attrs.password,
             Ecto.Changeset.get_change(changeset, :password_digest)
           )

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
