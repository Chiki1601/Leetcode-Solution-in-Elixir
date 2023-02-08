defmodule Solution do
  @spec jump(nums :: [integer]) :: integer
  def jump(nums) do
    min_jump(nums, 0, 0, length(nums) - 1, 0)
  end
  
  defp min_jump(_, move, _, dest, ans) when move >= dest, do: ans
  defp min_jump(_, _, next_move, dest, ans) when next_move >= dest, do: ans + 1
  defp min_jump([x | nums], 0, next_move, dest, ans) do
    min_jump(nums, max(x, next_move) - 1, 0, dest - 1, ans + 1)
  end
  defp min_jump([x | nums], move, next_move, dest, ans) do
    min_jump(nums, move - 1, max(x, next_move) - 1, dest - 1, ans)
  end
end
