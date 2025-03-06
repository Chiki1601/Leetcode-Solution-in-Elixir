defmodule Solution do
  @spec find_missing_and_repeated_values(grid :: [[integer]]) :: [integer]
  def find_missing_and_repeated_values(grid) do
    n = length(grid)

    actual = grid |> List.flatten() |> Enum.sort()
    expected = Enum.to_list(1..n*n)

    actual
    |> List.myers_difference(expected)
    |> Enum.reject(&elem(&1, 0) == :eq)
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
    |> Enum.map(&hd/1)
  end
end
