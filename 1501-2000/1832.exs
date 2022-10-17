defmodule Solution do
  @spec check_if_pangram(sentence :: String.t) :: boolean
  def check_if_pangram(sentence), do: (MapSet.new(sentence |> String.to_charlist) |> MapSet.size) == 26
end
