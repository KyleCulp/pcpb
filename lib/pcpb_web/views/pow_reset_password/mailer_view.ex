defmodule PcpbWeb.PowResetPassword.MailerView do
  use PcpbWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
