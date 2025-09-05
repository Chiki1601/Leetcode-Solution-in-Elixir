defmodule Solution do
  import Bitwise

  @spec make_the_integer_zero(num1 :: integer, num2 :: integer) :: integer
  def make_the_integer_zero(num1, num2) do
    Enum.reduce_while(0..60, -1, fn t, _acc ->
      s = num1 - t * num2

      cond do
        s < 0 ->
          {:cont, -1}

        s < t ->
          {:cont, -1}

        true ->
          ones = bit_count(s)

          if ones <= t do
            {:halt, t}
          else
            {:cont, -1}
          end
      end
    end)
  end

  defp bit_count(0), do: 0
  defp bit_count(n), do: do_bit_count(n, 0)

  defp do_bit_count(0, count), do: count
  defp do_bit_count(n, count), do: do_bit_count(n &&& (n - 1), count + 1)
end
