defmodule Solution do
  @spec clear_digits(s :: String.t) :: String.t
  def clear_digits(s), do: do_clear_digits(s, [])

  defp do_clear_digits(<<>>, acc_list), do: Enum.reverse(acc_list) |> List.to_string()
  defp do_clear_digits(<<ch, rest::bytes>>, []), do: do_clear_digits(rest, [ch])
  defp do_clear_digits(<<ch, rest::bytes>>, [prev_ch | rest_ch] = acc_list) do
    if number?(ch) and !number?(prev_ch),
    do: do_clear_digits(rest, rest_ch),
    else: do_clear_digits(rest, [ch | acc_list])
  end

  defp number?(ch), do: ch >= ?0 and ch <= ?9
end
