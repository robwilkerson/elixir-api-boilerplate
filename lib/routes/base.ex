defmodule Routes.Base do
  defmacro __using__([]) do
    quote do
      use Plug.Router

      require Logger

      plug(:match)
      plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
      plug(:dispatch)

      @doc """
      Send a response from the service
      """
      defp send(conn, code, data) when is_integer(code) do
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> send_resp(code, Jason.encode!(data))
      end

      @doc """
      Maps a status code atom to its numeric response code. Prefer the use of
      atoms in routes for readability
      """
      defp send(conn, code, data) when is_atom(code) do
        code =
          case code do
            :ok -> 200
            :created -> 201
            :accepted -> 202
            :no_content -> 204
            :bad_request -> 400
            :unauthorized -> 401
            :forbidden -> 403
            :not_found -> 404
            :method_not_allowed -> 405
            :malformed_data -> 400
            :non_authenticated -> 401
            :forbidden_access -> 403
            :server_error -> 500
            :not_implemented -> 501
            :error -> 504
          end

        if code >= 400 do
          Logger.error(data)
        end

        send(conn, code, data)
      end
    end
  end
end
