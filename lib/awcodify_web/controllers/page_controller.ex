defmodule AwcodifyWeb.PageController do
  use AwcodifyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
