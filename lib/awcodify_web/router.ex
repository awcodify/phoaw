defmodule AwcodifyWeb.Router do
  use AwcodifyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AwcodifyWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AwcodifyWeb do
  #   pipe_through :api
  # end
end
