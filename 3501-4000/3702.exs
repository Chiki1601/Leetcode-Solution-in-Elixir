defmodule Solution do
  @spec longest_subsequence(nums :: [integer]) :: integer
  def longest_subsequence(nums) do
    xor_sum = Enum.reduce(nums, 0, fn num, acc -> Bitwise.bxor(acc, num) end)
    all_zero = Enum.all?(nums, fn num -> num == 0 end)

    cond do
      all_zero -> 0
      xor_sum != 0 -> length(nums)
      true -> length(nums) - 1
    end
  end
end
