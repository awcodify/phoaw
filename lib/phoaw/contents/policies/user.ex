defmodule Phoaw.Policies.User do
  @behaviour Bodyguard.Policy

  alias Phoaw.Contents.User

  # Regular users can modify their own posts
  def authorize(action, %User{id: id}, %User{id: id})
    when action in [:edit_user], do: true
end