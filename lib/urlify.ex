defmodule Botixir.Urlify do
  def convert(text) do
    urlRegex = ~r/http(?:s)?\:\/\/(?:www.)?twitter.com\/[0-9a-zA-Z_-]*\/[0-9a-zA-Z_-]*\/([0-9])*/
    match = Regex.scan(urlRegex, text, capture: :first)
    match |> List.flatten |> Botixir.Twstream.getUrls
  end
end