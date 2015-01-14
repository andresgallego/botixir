ExUnit.start

defmodule UrlifyTest do
  use ExUnit.Case, async: true

  test "Get two post's url from twitter" do
    assert Botixir.Urlify.convert("Hey look at this https://twitter.com/andresfortinero/status/555366730084929537
      and https://twitter.com/julian_duque/status/555208342600425472 but not
      https://twitter.com/andresfortinero") ==
      ["https://twitter.com/andresfortinero/status/555366730084929537",
       "https://twitter.com/julian_duque/status/555208342600425472"]
  end

  test "Given urls doesn't match with twitter posts" do
    assert Botixir.Urlify.convert("https://twitter.com/julian_duque") == []
  end
end