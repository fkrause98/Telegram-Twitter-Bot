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

  def handle({:command, :help, _msg}, context) do
    answer(context, "Here is your help:")
  end

  def handle({:update, update}, context) do
    # case Nitter.from
    answer(context, "Here is your update:")
  end

  def handle({:text, text, _message}, context) do
    case Nitter.from_twitter(text) do
      {:error, :twitter_url_not_found} ->
        nil

      nitter_url ->
        answer(
          context,
          "Pero usá nitter, pedazo de virgo \n" <>
            nitter_url
        )
    end
  end
end
