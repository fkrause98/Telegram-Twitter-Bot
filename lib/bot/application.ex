defmodule Bot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # This will setup the Registry.ExGram
      ExGram,
      {Bot.Handler, [method: :polling, token: System.fetch_env!("BOT_TOKEN")]}
    ]

    opts = [strategy: :one_for_one, name: Bot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
