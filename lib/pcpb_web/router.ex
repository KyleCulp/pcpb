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
  end

  scope "/", PcpbWeb do
    pipe_through [:browser, :admin]

    live "/admin", AdminLive.Index, :index
    live "/admin/parts", AdminLive.Parts.Index, :index

    live "/admin/parts/cpu", AdminLive.Parts.Part, :cpu
    live "/admin/parts/cpu/new", AdminLive.Parts.Part, :cpu_new
    live "/admin/parts/cpu/:id", AdminLive.Parts.Part, :cpu_edit
    live "/admin/parts/cpu_cooler", AdminLive.Parts.Part, :cpu_cooler
    live "/admin/parts/cpu_cooler/new", AdminLive.Parts.Part, :cpu_cooler_new
    live "/admin/parts/cpu_cooler/:id", AdminLive.Parts.Part, :cpu_cooler_edit
    live "/admin/parts/case", AdminLive.Parts.Part, :case
    live "/admin/parts/case/new", AdminLive.Parts.Part, :case_new
    live "/admin/parts/case/:id", AdminLive.Parts.Part, :case_edit
    live "/admin/parts/gpu", AdminLive.Parts.Part, :gpu
    live "/admin/parts/gpu/new", AdminLive.Parts.Part, :gpu_new
    live "/admin/parts/gpu/:id", AdminLive.Parts.Part, :gpu_edit
    live "/admin/parts/memory", AdminLive.Parts.Part, :memory
    live "/admin/parts/memory/new", AdminLive.Parts.Part, :memory_new
    live "/admin/parts/memory/:id", AdminLive.Parts.Part, :memory_edit
    live "/admin/parts/psu", AdminLive.Parts.Part, :psu
    live "/admin/parts/psu/new", AdminLive.Parts.Part, :psu_new
    live "/admin/parts/psu/:id", AdminLive.Parts.Part, :psu_edit

    # live "/admin/parts/cpu", AdminLive.Parts.CPU, :index
    # live "/admin/parts/cpu/new", AdminLive.Parts.CPU, :new
    # live "/admin/parts/cpu/:id", AdminLive.Parts.CPU, :edit

    # live "/admin/parts/case", AdminLive.Parts.Case, :index
    # live "/admin/parts/case/new", AdminLive.Parts.Case, :new
    # live "/admin/parts/case/:id", AdminLive.Parts.Case, :edit

    # live "/admin/parts/cpu_cooler", AdminLive.Parts.CPUCooler, :index
    # live "/admin/parts/cpu_cooler/new", AdminLive.Parts.CPUCooler, :new
    # live "/admin/parts/cpu_cooler/:id", AdminLive.Parts.CPUCooler, :edit
  end
end
