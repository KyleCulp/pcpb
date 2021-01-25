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
    plug Pow.Plug.Session, otp_app: :pcpb
    plug PcpbWeb.AssignUser
  end

  pipeline :old_admin do
    plug :put_root_layout, {PcpbWeb.OldAdminView, :layout}
    plug :put_layout, {PcpbWeb.OldAdminView, :live}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler

    plug PcpbWeb.AssignUser
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: PcpbWeb.AuthErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", PcpbWeb do
    pipe_through [:browser, :not_authenticated]

    get "/signup", RegistrationController, :new, as: :signup
    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", PcpbWeb do
    pipe_through :browser
    live "/", PageLive, :index

  end

  @products [:cpu, :cpu_cooler, :memory, :case, :psu, :gpu, :motherboard, :storage]


  scope "/products", PcpbWeb do
    pipe_through :browser
    live "/", ProductLive.Index, :index
    live "/new", ProductLive.Index, :new
    live "/edit/:id", ProductLive.Show, :edit
    live "/:category", ProductLive.Index, :index
    live "/:category/:id", ProductLive.Show, :index

      # for product <- @products do
      #   live "/#{product}", ProductLive.Index, product
      #   live "/#{product}/:id", ProductLive.Show, String.to_atom("#{product}_show")
      #   live "/#{product}/:id/edit", ProductLive.Index, String.to_atom("#{product}_edit")
      #   live "/#{product}/new", ProductLive.Index, String.to_atom("#{product}_new")
      # end
  end

  scope "/oldadmin", PcpbWeb do
    pipe_through [:browser, :old_admin]

    live "/admin", AdminLive.Index, :index
    live "/admin/parts", AdminLive.Parts.Index, :index

    for part <- @products do
      live "/admin/parts/#{part}", AdminLive.Parts.Part, part
      live "/admin/parts/#{part}/new", AdminLive.Parts.Part, String.to_atom("#{part}_new")
      live "/admin/parts/#{part}/:id", AdminLive.Parts.Part, String.to_atom("#{part}_edit")
    end
  end
end
