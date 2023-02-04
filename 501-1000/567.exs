defmodule Solution do
  @spec check_inclusion(s1 :: String.t, s2 :: String.t) :: boolean
  def check_inclusion(s1, s2) do
    len = String.length(s1)
    freq =
      String.to_charlist(s1)
      |> Enum.frequencies()
    List.duplicate(?_, len)
    |> Stream.concat(String.to_charlist(s2))
    |> Enum.zip(String.to_charlist(s2))
    |> check?(freq, len)
  end

  defp check?(_, _, 0), do: true
  defp check?([], _, _), do: false
  defp check?([{ch1, ch2} | list], freq, need) do
    case Map.get(freq, ch2) do
      nil -> {freq, need}
      x when x > 0 -> {Map.update!(freq, ch2, &(&1 - 1)), need - 1}
      _ -> {Map.update!(freq, ch2, &(&1 - 1)), need}
    end
    |> then(fn {freq, need} ->
      case Map.get(freq, ch1) do
        nil -> {freq, need}
        x when x >= 0 -> {Map.update!(freq, ch1, &(&1 + 1)), need + 1}
        _ -> {Map.update!(freq, ch1, &(&1 + 1)), need}
      end
    end)
    |> then(fn {freq, need} ->
      check?(list, freq, need)
    end)
  end
end
