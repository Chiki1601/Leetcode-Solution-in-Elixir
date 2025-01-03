defmodule Solution do
  @spec ways_to_split_array(nums :: [integer]) :: integer
  def ways_to_split_array(nums) do
    Enum.sum(nums)
    |> solve(nums, 0)
  end
  
  defp solve(_, [_], ans), do: ans
  defp solve(acc, [x | tail], ans) do
    acc2 = acc - x * 2
    if acc2 <= 0 do
      solve(acc2, tail, ans + 1)
    else
      solve(acc2, tail, ans)
    end
  end
end
