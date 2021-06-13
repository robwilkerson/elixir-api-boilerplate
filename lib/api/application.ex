defmodule Api.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: port()]}

      # Starts a worker by calling: Api.Worker.start_link(arg)
      # {Api.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Api.Supervisor]

    Logger.info("Starting the #{Mix.env()} server on port #{port()}")
    Supervisor.start_link(children, opts)
  end

  defp port, do: Application.get_env(:api, :port, 4000)
end
