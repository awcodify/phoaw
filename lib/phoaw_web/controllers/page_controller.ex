defmodule PhoawWeb.PageController do
  use PhoawWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
