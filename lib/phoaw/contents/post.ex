defmodule Phoaw.Contents.Post do
  @moduledoc """
    TODO: add documentations here
  """
  use Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :body, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
