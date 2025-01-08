defmodule Solution do
  @spec count_prefix_suffix_pairs(words :: [String.t]) :: integer
  def count_prefix_suffix_pairs(words) do
    helper(words, words |> tl, 0)
  end

  @spec helper(words1 :: [String.t], words2 :: [String.t], ans :: integer) :: integer
  def helper([_h1 | []], [], ans) do
    ans
  end

  def helper([_h1 | [t1h | t1t]], [], ans) do
    helper([t1h | t1t], t1t, ans)
  end

  def helper([h1 | t1], [h2 | t2], ans) do
    if String.starts_with?(h2, h1) and String.ends_with?(h2, h1) do
      helper([h1 | t1], t2, ans + 1)
    else
      helper([h1 | t1], t2, ans)
    end
  end
end
