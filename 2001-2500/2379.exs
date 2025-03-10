defmodule Solution do
  @spec minimum_recolors(blocks :: String.t, k :: integer) :: integer
  def minimum_recolors(blocks, k) do
    blocks_list = String.graphemes(blocks)
    freq = Enum.take(blocks_list, k) |> Enum.frequencies()
    minimum_recolors(blocks_list, k, 0, freq, Map.get(freq, "W", 0))
  end

  defp minimum_recolors(blocks, k, i, freq, ans) when length(blocks) - k <= i do
    ans
  end

  defp minimum_recolors(blocks, k, i, freq, ans) do
    new_freq = Map.update!(freq, Enum.at(blocks, i), &(&1 - 1))
    new_freq2 = Map.update(new_freq, Enum.at(blocks, i + k), 1, &(&1 + 1))
    minimum_recolors(blocks, k, i + 1, new_freq2, min(ans, Map.get(new_freq2, "W", 0)))
  end
end
