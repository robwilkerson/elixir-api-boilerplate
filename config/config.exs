import Config

config :logger_json, :backend, metadata: :all

config :logger,
  utc_log: true,
  level: :warn,
  backends: [LoggerJSON]

import_config("#{Mix.env()}.exs")
