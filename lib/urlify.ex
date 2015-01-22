defmodule Botixir.Urlify do
  def convert text do
    urlRegex = ~r{http(?:s)?\:\/\/(?:www.)?twitter.com\/[0-9a-zA-Z_-]*\/[0-9a-zA-Z_-]*\/([0-9])*}i
    match = Regex.scan(urlRegex, text, capture: :first)
    match |> List.flatten
  end

  def call_twitter(fun, text) do
    fun.(text) |> Botixir.Twstream.getUrls
  end
end