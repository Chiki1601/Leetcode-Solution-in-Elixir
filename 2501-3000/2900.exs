defmodule Solution do
  @spec get_longest_subsequence(words :: [String.t], groups :: [integer]) :: [String.t]
  def get_longest_subsequence(words, groups) do
    Enum.zip(words, groups)
    |> tl
    |> Enum.reduce({groups |> hd, [words |> hd]}, fn {w, g}, {pre_group, ans} ->
      if g == pre_group do
        {g, ans}
      else
        {g, [w] ++ ans}
      end
    end)
    |> elem(1)
    |> Enum.reverse()
  end
end
