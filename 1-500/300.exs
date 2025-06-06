defmodule Solution do
  @spec length_of_lis(nums :: [integer]) :: integer
  def length_of_lis(nums) do
    Enum.reduce(nums, :gb_sets.new(), fn x, gb ->
      :gb_sets.iterator_from(x, gb)
      |> :gb_sets.next()
      |> then(fn
        :none -> :gb_sets.insert(x, gb)
        {^x, _} -> gb
        {y, _} ->
          :gb_sets.delete(y, gb)
          |> then(&:gb_sets.insert(x, &1))
      end)
    end)
    |> :gb_sets.size()
  end
end
