defmodule Solution do
  @spec generate(num_rows :: integer) :: [[integer]]
  def generate(0), do: []
                   
  def generate(1), do: [[1]]

  def generate(num_rows) do
    num_rows
    |> Kernel.-(2)
    |> gen([[1,1], [1]])
    |> Enum.reverse()
  end
    
  defp gen(0, rows), do: rows
  
  defp gen(n, [prev_row | _] = rows) do
    row =
      prev_row
      |> Stream.chunk_every(2, 1, :discard)
      |> Stream.map(fn [a, b] -> a + b end)
      |> Enum.reduce([1], fn n, acc -> [n | acc] end)
      |> then(&[1 | &1])

    gen(n - 1, [row | rows])
  end
end
