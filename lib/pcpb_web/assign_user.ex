defmodule PcpbWeb.AssignUser do
  import Plug.Conn
  alias Pcpb.Users.User

  def init(options), do: options

  def call(conn, params) do
    case Pow.Plug.current_user(conn) do
      %User{} = user ->
        conn |> put_session("user_id", user.id)

      _ ->
        conn
    end
  end
end
