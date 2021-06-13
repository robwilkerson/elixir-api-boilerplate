defmodule Router do
  use Plug.Router

  require Logger

  plug(Plug.Logger, log: :info)

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  forward("/users", to: Routes.Users)

  match _ do
    Logger.warn("#{conn.request_path} not found")
    send_resp(conn, 404, "Not found!")
  end
end
