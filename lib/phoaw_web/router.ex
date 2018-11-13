defmodule PhoawWeb.Router do
  use PhoawWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", PhoawWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoawWeb do
  #   pipe_through :api
  # end
end
