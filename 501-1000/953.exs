defmodule Solution do
  @spec is_alien_sorted(words :: [String.t], order :: String.t) :: boolean
  def is_alien_sorted(words, order) do
    String.to_charlist(order)
    |> Enum.with_index()
    |> Map.new()
    |> sorted?(words)
  end

  defp sorted?(map, [w1, w2 | words]) do
    if asc?(w1, w2, map) do
      sorted?(map, [w2 | words])
    else
      false
    end
  end
  defp sorted?(_, _), do: true

  defp asc?("", _, _), do: true
  defp asc?(_, "", _), do: false
  defp asc?(<<ch1, w1::binary>>, <<ch2, w2::binary>>, map) do
    case {Map.get(map, ch1), Map.get(map, ch2)} do
      {a, b} when a < b -> true
      {a, b} when a > b -> false
      _ -> asc?(w1, w2, map)
    end
  end
end
