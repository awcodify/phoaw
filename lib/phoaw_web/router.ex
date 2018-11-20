defmodule PhoawWeb.Router do
  use PhoawWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Phoaw.Auth.Pipeline
  end
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", PhoawWeb do
    pipe_through :browser

    get "/", PageController, :index
    # resources "/posts", PostController
    resources "/sessions", SessionController
    # resources "/users", UserController
    post "/logout", SessionController, :logout
  end

  scope "/", PhoawWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    resources "/posts", PostController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoawWeb do
  #   pipe_through :api
  # end
end
