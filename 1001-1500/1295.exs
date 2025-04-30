# Time O(n)
# Space O(1)
defmodule Solution do
  @spec find_numbers(nums :: [integer]) :: integer
  def find_numbers(nums), do: do_find_numbers(nums, 0)

  defp do_find_numbers([], count), do: count
  defp do_find_numbers([head | tail], count) do
    if (head >= 10 && head <= 99) || (head >= 1_000 && head <= 9_999) || head == 100_000 do
      do_find_numbers(tail, count + 1)
    else
      do_find_numbers(tail, count)
    end
  end
end
