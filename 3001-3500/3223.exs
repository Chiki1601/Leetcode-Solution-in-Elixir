defmodule Solution do
  @spec minimum_length(s :: String.t()) :: integer
  def minimum_length(s) do
    if String.length(s) <= 2 do
      String.length(s)
    else
      s
      |> String.graphemes()
      |> Enum.reduce({%{}, 0}, fn c, {d, r} ->
        curr = Map.get(d, c, 0)
        d = Map.put(d, c, if(curr + 1 > 2, do: 1, else: curr + 1))
        r = r + (Map.get(d, c, 0) - curr)
        {d, r}
      end)
      |> elem(1)
    end
  end
end
