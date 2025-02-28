defmodule Solution do
  @spec shortest_common_supersequence(str1 :: String.t, str2 :: String.t) :: String.t
  def shortest_common_supersequence(str1, str2) do
    str1
    |> String.myers_difference(str2)
    |> Enum.map(&elem(&1, 1))
    |> Enum.join()
  end
end
