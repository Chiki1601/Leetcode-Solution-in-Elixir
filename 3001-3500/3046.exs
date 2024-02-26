# 316ms - 336ms
defmodule Solution do
  @spec is_possible_to_split(nums :: [integer]) :: boolean
  def is_possible_to_split(nums) do
    Enum.reduce_while(nums, {%{}, false}, fn num, {cnts, _ans} ->
      cnts = Map.put(cnts, num, Map.get(cnts, num, 0) + 1)
      if cnts[num] == 3 do
        {:halt, {cnts, false}}
      else
        {:cont, {cnts, true}}
      end
    end)
    |> elem(1)
  end
ends
