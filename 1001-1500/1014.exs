defmodule Solution do
  def max_score_sightseeing_pair(values) do
    [first | rest] = values
    rest
    |> Enum.reduce({0, first, 1}, fn value, {max, score, i} ->
      score = score - 1
      new_max = max(max, score + value)
      new_score = max(score, value)
      {new_max, new_score, i + 1}
    end)
    |> elem(0)
  end
end
