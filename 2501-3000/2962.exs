defmodule Solution do
  @spec count_subarrays(nums :: [integer], k :: integer) :: integer
  def count_subarrays(nums, k) do
    max = Enum.max(nums)
    list =
      Enum.with_index(nums)
      |> Enum.filter(fn {x, _} -> x == max end)
    Enum.drop(list, k - 1)
    |> Enum.chunk_every(2, 1)
    |> Enum.zip_with(list, fn
      [{_, j}, {_, k}], {_, i} -> (i + 1) * (k - j)
      [{_, j}], {_, i} -> (i + 1) * (length(nums) - j)
    end)
    |> Enum.sum()
  end
end
