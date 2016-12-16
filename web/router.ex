defmodule HelloPhoenix.Router do
  # makes Phoenix router functions available to our router
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # pipelines allow a set of middleware-esque transformations to be
  # applied to a different set of routes
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    # 'get' is a Phoenix macro which expands out to define
    # one clause of the match/3 function. It corresponds to
    # the HTTP verb GET.

    # If this were the only route in this router module,
    # the clause of the match/3 function would look like this
    # after the macro is expanded:
    #   def match(conn, "GET", ["/"])
    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController
    resources "/posts", PostController, only: [:index, :show]
    resources "/comments", CommentController, except: [:delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
