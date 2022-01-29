defmodule Bot.Handler do
  @bot :bot

  use ExGram.Bot,
    name: @bot,
    setup_commands: true

  command("start")
  command("help", description: "Print the bot's help")

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, :start, _msg}, context) do
    answer(context, "Oh my god hi!")
  end

  def handle({:location, location}, context) do
    answer(context, "Doxxeado, lince")
  end

  def handle({:text, text, _message}, context) do
    case Nitter.from_twitter(text) do
      {:error, :twitter_url_not_found} ->
        nil

      nitter_url ->
        answer(
          context,
          "Usá nitter, pedazo de virgo \n" <>
            nitter_url
        )
    end
  end

  def handle(_, _), do: nil
end
