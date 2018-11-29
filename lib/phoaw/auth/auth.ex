defmodule Phoaw.Auth.Auth do
  @moduledoc """
  This module define Guardian authenticate user
  """

  import Ecto.Query, warn: false

  alias Phoaw.Repo
  alias Comeonin.Bcrypt
  alias Phoaw.Contents

  def authenticate_user(username, plain_text_password) do
    user = Contents.get_user_by_username!(username)
    user |> check_password(plain_text_password)
  end

  defp check_password(nil, _), do: {:error, "Incorrect username or password"}

  defp check_password(user, plain_text_password) do
    case Bcrypt.checkpw(plain_text_password, user.password_digest) do
      true -> {:ok, user}
      false -> {:error, "Incorrect username or password"}
    end
  end
end
