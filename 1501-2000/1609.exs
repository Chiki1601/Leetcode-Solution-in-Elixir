defmodule Solution do
  require Integer

  @spec is_even_odd_tree(root :: TreeNode.t | nil) :: boolean
  def is_even_odd_tree(root) do
    odd?([root])
  end

  defp odd?([]), do: true

  defp odd?(layer) do
    values = Enum.map(layer, & &1.val)
    Enum.all?(values, &Integer.is_odd/1) &&
    (values |> Stream.chunk_every(2, 1, :discard) |> Enum.all?(fn [a, b] -> a < b end)) &&
    even?(layer |> Stream.flat_map(&[&1.left, &1.right]) |> Enum.reject(&is_nil/1))
  end

  defp even?([]), do: true

  defp even?(layer) do
    values = Enum.map(layer, & &1.val)
    Enum.all?(values, &Integer.is_even/1) &&
    (values |> Stream.chunk_every(2, 1, :discard) |> Enum.all?(fn [a, b] -> a > b end)) &&
    odd?(layer |> Stream.flat_map(&[&1.left, &1.right]) |> Enum.reject(&is_nil/1))
  end
end
