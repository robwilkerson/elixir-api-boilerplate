defmodule Router do
  use Plug.Router

  require Logger

  # config(:logger, backends: [:console])

  plug(Plug.RequestId, http_header: "x-request-id")
  plug(Plug.LoggerJSON, log: :info)
  plug(:match)
  # middleware?
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  # Non-domain bits here: health check, etc.

  forward("/users", to: Routes.Users)

  match _ do
    Logger.warn("#{conn.request_path} not found")
    send_resp(conn, 404, "Whoops! We can't find what you're after.")
  end
end
