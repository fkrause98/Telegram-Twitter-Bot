defmodule Bot.Handler do
  @bot :bot

  use ExGram.Bot,
    name: @bot,
    setup_commands: true

  command("help", description: "Just send me a valid twitter URL")
  command("ping", description: "Pong")

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, :ping, _msg}, context) do
    answer(context, "Pong")
  end

  def handle({:location, _location}, context) do
    answer(context, "Doxxeado, lince")
  end

  def handle({:message, _message}, context) do
    answer(context, "Te respondo, lince")
  end

  def handle({:text, text, _message}, context) do
    case Nitter.from_twitter(text) do
      {:error, :twitter_url_not_found} ->
        nil

      nitter_url ->
        answer(
          context,
          "Usá nitter, capo \n" <>
            nitter_url
        )
    end
  end

  def handle(_, _), do: nil
end
