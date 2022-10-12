defmodule Solution do
  @spec largest_perimeter(nums :: [integer]) :: integer
  def largest_perimeter(nums) do
    Enum.sort(nums) |> Enum.reverse() |> do_perimeter()
  end

  def do_perimeter([h1 | [h2 | [h3 | t]]] = nums) when length(nums) >= 3 do
    if h2 + h3 > h1 do
      h1 + h2 + h3
    else
      do_perimeter([h2 | [h3 | t]])
    end
  end

  def do_perimeter(_) do
    0
  end
end
