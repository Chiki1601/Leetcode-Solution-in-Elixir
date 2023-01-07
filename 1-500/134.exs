defmodule Solution do
  @spec can_complete_circuit(gas :: [integer], cost :: [integer]) :: integer
  def can_complete_circuit(gas, cost) do
    list = Enum.zip_with(gas, cost, &(&1 - &2))
    len = length(list)
    find_station(list ++ list, 0, 0, 0, len)
  end

  defp find_station(_, _, start, len, len), do: start
  defp find_station(_, _, start, _, len) when start >= len, do: -1
  defp find_station([head | tail], fuel, start, dist, len) do
    if fuel + head >= 0 do
      find_station(tail, fuel + head, start, dist + 1, len)
    else
      find_station(tail, 0, start + dist + 1, 0, len)
    end
  end
end
