defmodule Router do
  use Plug.Router

  require Logger

  plug(Plug.RequestId, http_header: "x-request-id")
  plug(LoggerJSON.Plug, metadata_formatter: LoggerJSON.Plug.MetadataFormatters.ELK)
  plug(:match)
  # middleware?
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Jason)
  plug(:dispatch)

  # Non-domain bits here: health check, etc.

  forward("/users", to: Routes.Users)

  match _ do
    Logger.warn("#{conn.request_path} not found")
    send_resp(conn, 404, "Whoops! We can't find what you're after.")
  end
end
