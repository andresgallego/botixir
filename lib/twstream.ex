defmodule Botixir.Twstream do
  def getUrls(urls) when is_list(urls) do
    getUrls(urls, [])
  end

  defp getUrls([], results) do
    Enum.reverse(results) |> Enum.each(&(IO.puts(&1)))
  end

  defp getUrls([head | tail], results) do
    getUrls(tail, [showTweet(head) | results])
  end

  defp showTweet(url) do
    tweet = String.split(url, "/") |> List.last |> ExTwitter.show
    tweet.text
  end
end