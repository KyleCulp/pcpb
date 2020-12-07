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
    # plug PcpbWeb.AssignUser
  end

  pipeline :admin do
    plug :put_root_layout, {PcpbWeb.AdminView, :layout}
    plug :put_layout, {PcpbWeb.AdminView, :live}
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

  scope "/", PcpbWeb do
    pipe_through [:browser, :not_authenticated]

    get "/signup", RegistrationController, :new, as: :signup
    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", PcpbWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/parts", PartLive.Index, :index
    live "/parts/new", PartLive.Index, :new
    live "/parts/:id/edit", PartLive.Index, :edit

    live "/parts/:id", PartLive.Show, :show
    live "/parts/:id/show/edit", PartLive.Show, :edit
    live "/cases", CaseLive.Index, :index
    live "/cases/new", CaseLive.Index, :new
    live "/cases/:id/edit", CaseLive.Index, :edit

    live "/cases/:id", CaseLive.Show, :show
    live "/cases/:id/show/edit", CaseLive.Show, :edit

    live "/cpu_coolers", CPUCoolerLive.Index, :index
    live "/cpu_coolers/new", CPUCoolerLive.Index, :new
    live "/cpu_coolers/:id/edit", CPUCoolerLive.Index, :edit

    live "/cpu_coolers/:id", CPUCoolerLive.Show, :show
    live "/cpu_coolers/:id/show/edit", CPUCoolerLive.Show, :edit

  end

  scope "/", PcpbWeb do
    pipe_through [:browser, :admin]

    live "/admin", AdminLive.Index, :index
    live "/admin/parts", AdminLive.Parts.Index, :index

    live "/admin/parts/cpu", AdminLive.Parts.CPU, :index
    live "/admin/parts/cpu/new", AdminLive.Parts.CPU, :new
    live "/admin/parts/cpu/:id", AdminLive.Parts.CPU, :edit

    live "/admin/parts/case", AdminLive.Parts.Case, :index
    live "/admin/parts/case/new", AdminLive.Parts.Case, :new
    live "/admin/parts/case/:id", AdminLive.Parts.Case, :edit
  end

end
