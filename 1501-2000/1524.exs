defmodule Solution do
  use Bitwise
  @large 1_000_000_007

  @spec num_of_subarrays(arr :: [integer]) :: integer
  def num_of_subarrays(arr) do
    Enum.reduce(arr, {0, 1, 0, 0}, fn x, {ans, even, odd, bit} ->
      if bit ^^^ (x &&& 1) == 0 do
        {rem(ans + odd, @large), even + 1, odd, 0}
      else
        {rem(ans + even, @large), even, odd + 1, 1}
      end
    end)
    |> elem(0)
  end
end
