defmodule Solution do
  @spec max_absolute_sum(nums :: [integer]) :: integer
  def max_absolute_sum(nums) do
    Enum.reduce(nums, {0, 0, 0}, fn x, {ans, pos, neg} ->
      pos = max(0, pos + x)
      neg = min(0, neg + x)
      ans = Enum.max([ans, pos, -neg])
      {ans, pos, neg}
    end)
    |> elem(0)
  end
end
