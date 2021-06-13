import Config

config :plug_logger_json,
  filtered_keys: [],
  suppressed_keys: ["api_version"]

config :logger,
  utc_log: true,
  level: :warn,
  backends: [{LoggerFileBackend, :access}]

config :logger, :access, path: "./logs/access.log"

import_config("#{Mix.env()}.exs")
