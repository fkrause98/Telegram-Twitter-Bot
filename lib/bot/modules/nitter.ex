defmodule Nitter do
  @url_regex ~r/(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})?/
  def from_twitter(text) do
    cond do
      contains_twitter_url?(text) ->
        text |> scan_and_get_urls |> urls_to_nitter |> maybe_remove_query

      true ->
        {:error, :twitter_url_not_found}
    end
  end

  defp contains_twitter_url?(nil), do: false
  defp contains_twitter_url?(url), do: String.contains?(url, "twitter.com")

  defp to_twitter(url) do
    String.replace(url, "twitter.com", "nitter.net")
  end

  defp scan_and_get_urls(text) do
    Regex.scan(@url_regex, text)
    |> Enum.map(&hd/1)
    |> reject_if_fx()
    |> Enum.map(&URI.parse/1)
  end

  defp reject_if_fx(urls) when is_list(urls) do
    urls
    |> Enum.reject(fn url -> url |> String.contains?("fxtwitter.com") end)
  end

  defp urls_to_nitter(urls) when is_list(urls) do
    urls
    |> Enum.map(&URI.to_string/1)
    |> Enum.map(&to_twitter/1)
    |> Enum.join("\n")
  end

  defp maybe_remove_query(url) do
    case String.split(url, "?") do
      [link, _q_params] -> link
      [link] -> link
    end
  end
end
