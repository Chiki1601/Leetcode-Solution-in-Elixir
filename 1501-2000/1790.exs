defmodule Solution do
  @spec are_almost_equal(s1 :: String.t, s2 :: String.t) :: boolean
  def are_almost_equal(s1, s2), do: byte_size(s1) == byte_size(s2) and do_are_almost_equal(s1, s2, %{}, %{}, 0)

  defp do_are_almost_equal(_, _, _, _, mismatch_count) when mismatch_count > 2, do: false
  defp do_are_almost_equal(<<s1, rest1::bytes>>, <<s2, rest2::bytes>>, s1_map, s2_map, mismatch_count) when s1 != s2 do 
    do_are_almost_equal(rest1, rest2, Map.update(s1_map, s1, 1, &(&1 + 1)), Map.update(s2_map, s2, 1, &(&1 + 1)), mismatch_count + 1)
  end
  defp do_are_almost_equal(<<_, rest1::bytes>>, <<_, rest2::bytes>>, s1_map, s2_map, mismatch_count) do
    do_are_almost_equal(rest1, rest2, s1_map, s2_map, mismatch_count)
  end
  defp do_are_almost_equal(_, _, s1_map, s2_map, mismatch_count), do: mismatch_count == 0 or (mismatch_count == 2 and s1_map == s2_map) 
end
