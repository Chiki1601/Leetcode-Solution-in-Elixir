defmodule Solution do
  @spec max_free_time(integer, integer, [integer], [integer]) :: integer
  def max_free_time(event_time, k, start_time, end_time) do
    count = length(start_time)

    start_time_tuple = List.to_tuple(start_time)
    end_time_tuple = List.to_tuple(end_time)

    # Build prefix sum of occupied time
    prefix_sum =
      0..(count - 1)
      |> Enum.reduce({[0], 0}, fn i, {acc, sum} ->
        occupied = elem(end_time_tuple, i) - elem(start_time_tuple, i)
        {[sum + occupied | acc], sum + occupied}
      end)
      |> elem(0)
      |> Enum.reverse()

    prefix_sum_tuple = List.to_tuple(prefix_sum)

    # Calculate max free time
    (k - 1)..(count - 1)
    |> Enum.reduce(0, fn i, acc ->
      occupied = elem(prefix_sum_tuple, i + 1) - elem(prefix_sum_tuple, i - k + 1)
      window_end = if i == count - 1, do: event_time, else: elem(start_time_tuple, i + 1)
      window_start = if i == k - 1, do: 0, else: elem(end_time_tuple, i - k)
      free_time = window_end - window_start - occupied
      max(acc, free_time)
    end)
  end
end
