defmodule Solution do
  @spec find_cheapest_price(n :: integer, flights :: [[integer]], src :: integer, dst :: integer, k :: integer) :: integer
  def find_cheapest_price(n, flights, src, dst, k) do
    Enum.reduce(0..k, %{src => 0}, fn _, cost ->
      Enum.reduce(flights, cost, fn [i, j, price], cost2 ->
        case Map.get(cost, i) do
          nil -> cost2
          x -> Map.update(cost2, j, x + price, &(min(&1, x + price)))
        end
      end)
    end)
    |> Map.get(dst, -1)
  end
end
