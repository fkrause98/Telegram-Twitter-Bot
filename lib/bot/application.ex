defmodule Bot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    options = [purge: true, max_bot_concurrency: 1000]

    set_token()
    {:ok, token} = :persistent_term.get(:token)

    children = [
      {Telegram.Bot.Async.Supervisor, {BotHandler, token, options}}
    ]

    opts = [strategy: :one_for_one, name: Bot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp set_token do
    case System.fetch_env("BOT_TOKEN") do
      :error ->
        Logger.error(missing_token: "Missing bot token")

      token ->
        :persistent_term.put(:token, token)
    end
  end
end
