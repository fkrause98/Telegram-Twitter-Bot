import Config

config :ex_gram, token: System.fetch_env!("BOT_TOKEN"),
  server: true,
  http: [:inet6, port: System.get_env("PORT")]
