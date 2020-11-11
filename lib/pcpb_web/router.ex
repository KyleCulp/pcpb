defmodule PcpbWeb.Router do
  use PcpbWeb, :router
  use Pow.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    otp_app: :pcpb,
    extensions: [PowResetPassword, PowPersistentSession]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PcpbWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler

    plug PcpbWeb.AssignUser
  end


  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", PcpbWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PcpbWeb do
  #   pipe_through :api
  # end
end
