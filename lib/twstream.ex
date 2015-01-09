defmodule Botixir.Twstream do
	ExTwitter.search("elixir-lang", [count: 5]) |>
	Enum.map(fn(tweet) -> tweet.text end) |>
	Enum.join("\n-----\n") |>
	IO.puts
end