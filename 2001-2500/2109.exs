defmodule Solution do
  @spec add_spaces(s :: String.t, spaces :: [integer]) :: String.t
  def add_spaces(s, spaces) do
    spaces =
      spaces
      |> Enum.map(&{?\s, &1 - 0.5})

    s
    |> String.to_charlist()
    |> Enum.with_index()
    |> Kernel.++(spaces)
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.map(&elem(&1, 0))
    |> List.to_string()
  end
end
