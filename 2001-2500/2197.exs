defmodule Solution do
  @spec replace_non_coprimes(nums :: [integer]) :: [integer]
  def replace_non_coprimes(nums) do
    solve(nums, [1])
  end

  defp solve([num | nums], [top | rest] = stack) do
    case Integer.gcd(num, top) do
      1 -> solve(nums, [num | stack])
      gcd -> solve([div(num * top, gcd) | nums], rest)
    end
  end

  defp solve([], acc) do
    acc
    |> Enum.reverse()
    |> tl()
  end
end
