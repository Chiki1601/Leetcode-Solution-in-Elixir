defmodule Solution do
  @spec number_of_pairs(points :: [[integer]]) :: integer
  def number_of_pairs(points) do
    points
    |> Enum.sort_by(fn [x, y] -> {x, -y} end)
    |> Enum.map(&List.last/1)
    |> pairs(0)
  end

  @abyss (-1_000_000_001)

  defp pairs([], count), do: count

  defp pairs([y, y | t], count) do
    pairs([y | t], count + 1)
  end

  defp pairs([y | t], count) do
    pairs(t, count + asc(t, @abyss, y, 0))
  end

  # `asc` is a function for
  # finding the length of
  # the first strictly ascending sequence
  # within the range (lo, hi]
  defp asc([], _lo, _hi, len), do: len

  defp asc([hi | _t], _lo, hi, len) do
    len + 1
  end

  defp asc([y | t], lo, hi, len) when y > lo and y < hi do
    asc(t, y, hi, len + 1)
  end

  defp asc([_ | t], lo, hi, len) do
    asc(t, lo, hi, len)
  end
end
