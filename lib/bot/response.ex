defmodule BotResponse do
  @behaviour Telegram.Bot
  def token, do: :persistent_term.get(:token) |> (fn {:ok, token} -> token end).()

  def maybe_send_message(message) do
    case message["text"] |> Nitter.from_twitter() do
      {:error, _} ->
        :noop

      url ->
        Telegram.Api.request(token(), "deleteMessage",
          chat_id: message["chat"]["id"],
          message_id: message["message_id"]
        )

        Telegram.Api.request(token(), "sendMessage",
          chat_id: message["chat"]["id"],
          text: url
        )
    end
  end
end
