defmodule Solution do
  @spec missing_number(nums :: [integer]) :: integer
  def missing_number(nums), do: solve(nums, 0, 0)

  def solve([], s, n), do: sum_interval(n) - s
  def solve([h | rest], s, n), do: solve(rest, s + h, n + 1)

  def sum_interval(n), do: div(n * (n + 1), 2)
end
