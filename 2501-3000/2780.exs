defmodule Solution do
  import Integer, only: [is_odd: 1]

  @spec minimum_index(nums :: [integer]) :: integer
  def minimum_index(nums) do
    thres =
      nums
      |> length()
      |> Kernel.+(1)
      |> div(2)

    dominant =
      nums
      |> Enum.frequencies()
      |> Enum.find(fn {_n, c} ->
        c > thres
      end)
      |> then(& &1 && elem(&1, 0))

    dominant && split(nums, dominant, 0, 0, 0) || -1    
  end

  defp split(_, _, i, dominant_count, dominated_count)
       when dominant_count > dominated_count,
       do: i - 1

  defp split([dominant | t], dominant, i, dominant_count, dominated_count) do
    split(t, dominant, i + 1, dominant_count + 1, dominated_count)
  end

  defp split([_ | t], dominant, i, dominant_count, dominated_count) do
    split(t, dominant, i + 1, dominant_count, dominated_count + 1)
  end
end
