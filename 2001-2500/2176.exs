defmodule Solution do
  @spec count_pairs(nums :: [integer], k :: integer) :: integer
  def count_pairs([_], k), do: 0
  def count_pairs(nums, k) do
    tuple = List.to_tuple(nums)
    max_i = tuple_size(tuple) - 1
    for i <- 0..max_i-1, j <- 1..max_i, i < j, elem(tuple, i) == elem(tuple, j),
        rem(i * j, k) == 0, reduce: 0 do
      acc -> acc + 1
    end      
  end
end
