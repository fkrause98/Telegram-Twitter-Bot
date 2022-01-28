defmodule BotHandler do
  @behaviour Telegram.Bot

  @impl Telegram.Bot
  def handle_update(%{"message" => message} = _arg, _token) do
    Task.async(fn -> BotResponse.maybe_send_message(message) end)
  end
end
