defmodule Solution do
  @spec gcd_of_strings(str1 :: String.t, str2 :: String.t) :: String.t
  def gcd_of_strings(str1, str2) do
    l1 = String.length(str1)
    l2 = String.length(str2)
    lgcd = gcd(l1, l2)
    
    [str1, str2]
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Stream.cycle/1)
    |> Enum.map(&Stream.chunk_every(&1, lgcd))
    |> Stream.zip
    |> Enum.take(max(div(l1, lgcd), div(l2,lgcd)))
    |> Enum.reduce_while([], fn {chnk1, chnk1}, res -> {:cont, chnk1}
                                {chnk1, chnk2}, _res -> {:halt, []}
                        end)
    |> Enum.join()                           
  end

  def gcd(a,0), do: abs(a)
  def gcd(a,b), do: gcd(b, rem(a,b))
end
