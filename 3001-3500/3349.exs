defmodule Solution do
  @spec has_increasing_subarrays(nums :: [integer], k :: integer) :: boolean
  def has_increasing_subarrays([hd | tl], k), do: do_has_increasing_subarrays(tl, hd, 1, 0, k)

  defp do_has_increasing_subarrays([], _prev_n, cur_len, prev_len, k), do: prev_len >= k && cur_len >= k
  defp do_has_increasing_subarrays([n | tl], prev_n, cur_len, prev_len, k) do
    cond do
      n > prev_n ->
        cur_len = cur_len + 1
        cur_len == 2 * k || do_has_increasing_subarrays(tl, n, cur_len, prev_len, k)
      true ->  (prev_len >= k && cur_len >= k) || do_has_increasing_subarrays(tl, n, 1, cur_len, k) 
    end
  end
end
