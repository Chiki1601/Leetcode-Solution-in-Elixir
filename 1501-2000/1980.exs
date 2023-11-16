defmodule Solution do
  @spec find_different_binary_string(nums :: [String.t]) :: String.t
  def find_different_binary_string(nums) do
    bits = nums |> hd() |> byte_size()

    # Since `nums` has at most 16 elements,
    # there's no benefit converting it to a MapSet.
    nums = Enum.map(nums, &String.to_integer(&1, 2))

    0
    |> Stream.unfold(&{&1, &1 + 1})
    |> Enum.find(& &1 not in nums)
    |> Integer.to_string(2)
    |> String.pad_leading(bits, "0")
  end
end
