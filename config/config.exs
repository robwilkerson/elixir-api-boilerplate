import Config

config :plug_logger_json,
  filtered_keys: [],
  suppressed_keys: ["api_version", "log_type"]

import_config "#{Mix.env()}.exs"
