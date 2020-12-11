{application,pcpb,
             [{applications,[kernel,stdlib,elixir,logger,runtime_tools,mnesia,
                             phoenix,phoenix_ecto,ecto_sql,postgrex,
                             phoenix_live_view,floki,phoenix_html,
                             telemetry_metrics,telemetry_poller,jason,
                             plug_cowboy,pow,bamboo]},
              {description,"pcpb"},
              {modules,['Elixir.Pcpb','Elixir.Pcpb.Application',
                        'Elixir.Pcpb.DataCase','Elixir.Pcpb.Parts',
                        'Elixir.Pcpb.Parts.CPU',
                        'Elixir.Pcpb.Parts.CPU.CacheMap',
                        'Elixir.Pcpb.Parts.CPUCooler',
                        'Elixir.Pcpb.Parts.Case',
                        'Elixir.Pcpb.Parts.Case.ClearanceMap',
                        'Elixir.Pcpb.Parts.Case.DimensionsMap',
                        'Elixir.Pcpb.Parts.Case.DustFiltersMap',
                        'Elixir.Pcpb.Parts.Case.FanOptionsMap',
                        'Elixir.Pcpb.Parts.Case.RadiatorSupportMap',
                        'Elixir.Pcpb.PowMailer','Elixir.Pcpb.Repo',
                        'Elixir.Pcpb.Users.User','Elixir.PcpbWeb',
                        'Elixir.PcpbWeb.Admin.HeaderComponent',
                        'Elixir.PcpbWeb.AdminLive.Index',
                        'Elixir.PcpbWeb.AdminLive.Parts.CPU',
                        'Elixir.PcpbWeb.AdminLive.Parts.CPUFormComponent',
                        'Elixir.PcpbWeb.AdminLive.Parts.Case',
                        'Elixir.PcpbWeb.AdminLive.Parts.CaseFormComponent',
                        'Elixir.PcpbWeb.AdminLive.Parts.Index',
                        'Elixir.PcpbWeb.AdminView',
                        'Elixir.PcpbWeb.AssignUser',
                        'Elixir.PcpbWeb.AuthErrorHandler',
                        'Elixir.PcpbWeb.CaseLive.FormComponent',
                        'Elixir.PcpbWeb.CaseLive.Index',
                        'Elixir.PcpbWeb.CaseLive.Show',
                        'Elixir.PcpbWeb.ChannelCase',
                        'Elixir.PcpbWeb.ConnCase','Elixir.PcpbWeb.Endpoint',
                        'Elixir.PcpbWeb.ErrorHelpers',
                        'Elixir.PcpbWeb.ErrorView',
                        'Elixir.PcpbWeb.LayoutView',
                        'Elixir.PcpbWeb.LiveHelpers',
                        'Elixir.PcpbWeb.ModalComponent',
                        'Elixir.PcpbWeb.PageLive','Elixir.PcpbWeb.Pow.Helper',
                        'Elixir.PcpbWeb.Pow.RegistrationView',
                        'Elixir.PcpbWeb.Pow.SessionView',
                        'Elixir.PcpbWeb.PowResetPassword.MailerView',
                        'Elixir.PcpbWeb.PowResetPassword.ResetPasswordView',
                        'Elixir.PcpbWeb.RegistrationController',
                        'Elixir.PcpbWeb.RegistrationView',
                        'Elixir.PcpbWeb.Router',
                        'Elixir.PcpbWeb.Router.Helpers',
                        'Elixir.PcpbWeb.Router.PowExtensionRouter',
                        'Elixir.PcpbWeb.SessionController',
                        'Elixir.PcpbWeb.SessionView',
                        'Elixir.PcpbWeb.Telemetry',
                        'Elixir.PcpbWeb.UserSocket']},
              {registered,[]},
              {vsn,"0.1.0"},
              {mod,{'Elixir.Pcpb.Application',[]}}]}.