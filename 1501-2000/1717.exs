defmodule Solution do
  @spec maximum_gain(s :: String.t, x :: integer, y :: integer) :: integer
  def maximum_gain(s, x, y) do
    String.to_charlist(s)
    |> Enum.reduce({0, 0, 0}, fn
      ?a, {ans, a, b} when y >= x and b != 0 -> {ans + y, a, b - 1}
      ?a, {ans, a, b} -> {ans, a + 1, b}
      ?b, {ans, a, b} when x >= y and a != 0 -> {ans + x, a - 1, b}
      ?b, {ans, a, b} -> {ans, a, b + 1}
      _, {ans, a, b} -> {ans + min(a, b) * min(x, y), 0, 0}
    end)
    |> then(fn {ans, a, b} ->
      ans + min(a, b) * min(x, y)
    end)
  end
end
