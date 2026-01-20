defmodule Solution do
  @spec min_bitwise_array(nums :: [integer]) :: [integer]
  def min_bitwise_array(nums) do
    Enum.reduce(nums, [], fn num, ans ->
      if rem(num, 2) == 0 do
        [-1] ++ ans
      else
        [num - div(Bitwise.band(num + 1, -num - 1), 2)] ++ ans
      end
    end)
    |> Enum.reverse()
  end
end
