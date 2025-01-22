defmodule Solution do
  @spec highest_peak(is_water :: [[integer]]) :: [[integer]]
  def highest_peak(is_water) do
    is_water
    |> init()
    |> update()
    |> rotate()
    |> update()
    |> rotate()
    |> update()
    |> rotate()
    |> update()
    |> rotate()
  end

  # Converts the `is_water` grid to the grid of heights.
  # The height of each land tile is set to 9999.
  defp init(is_water) do
    Enum.map(is_water, &Enum.map(&1, fn
      1 -> 0
      0 -> 9999
    end))
  end

  # Updates the height of each land tile to the height of its left adjacent tile +1
  # if the update lowers the height of the current tile,
  # otherwise just keep the current height.
  defp update(tiles) do
    Enum.map(tiles, &Enum.scan(&1, fn curr, prev ->
      min(curr, prev + 1)
    end))
  end

  # Rotates the grid 90 degrees counter-clockwise.
  defp rotate(tiles) do
    tiles
    |> Enum.zip_with(&Function.identity/1)
    |> Enum.reverse()
  end
end
