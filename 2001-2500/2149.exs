# 770ms
defmodule Solution do
  @spec rearrange_array(nums :: [integer]) :: [integer]
  def rearrange_array(nums) do
    nums
    |> Enum.reduce([[], []], fn num, [pos, neg] ->
      if num < 0, do: [pos, [num | neg]], else: [[num | pos], neg]
    end)
    |> Enum.zip()
    |> Enum.reduce([], fn {p, n}, ls -> [p, n | ls] end)
  end
end
