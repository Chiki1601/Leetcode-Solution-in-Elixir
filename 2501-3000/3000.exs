defmodule Solution do
  @spec area_of_max_diagonal(dimensions :: [[integer]]) :: integer
  def area_of_max_diagonal(dimensions) do
    dimensions
    |> Enum.max_by(fn [w, h] ->
      {w * w + h * h, w * h}
    end)
    |> then(fn [w, h] ->
      w * h
    end)
  end
end
