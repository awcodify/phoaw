defmodule Phoaw.Auth.ErrorHandler do
  @moduledoc """
  This module handle response for error authentication using Guardian
  """

  import Plug.Conn
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> put_resp_content_type("application/html")
    |> send_resp(401, body)
  end
end
