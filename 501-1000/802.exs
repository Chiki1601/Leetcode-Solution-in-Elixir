defmodule Solution do
  @spec eventual_safe_nodes(graph :: [[integer]]) :: [integer]
  def eventual_safe_nodes(graph) do
    outbounds =
      graph
      |> Stream.with_index()
      |> Map.new(fn {v2s, v1} ->
        {v1, MapSet.new(v2s)}
      end)

    inbounds =
      outbounds
      |> Stream.flat_map(fn {v1, v2s} ->
        Enum.map(v2s, fn v2 -> {v2, v1} end)
      end)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    queue =
      outbounds
      |> Enum.filter(fn {v1, v2s} ->
        MapSet.size(v2s) == 0
      end)
      |> Enum.map(&elem(&1, 0))
      |> :queue.from_list()

    bfs(queue, inbounds, outbounds, [])
  end

  @empty_queue :queue.new()

  defp bfs(@empty_queue, _, _, safe) do
    Enum.sort(safe)
  end

  defp bfs(queue, inbounds, outbounds, safe) do
    {{:value, v2}, queue} = :queue.out(queue)
    v1s = inbounds[v2] || []
    {inbounds, outbounds, terminals} = delete_edges(inbounds, outbounds, v1s, v2, [])
    queue = Enum.reduce(terminals, queue, &:queue.in/2)
    bfs(queue, inbounds, outbounds, [v2 | safe])
  end

  defp delete_edges(inbounds, outbounds, v1s, v2, terminals) do
    {outbounds, terminals} =
      for v1 <- v1s, reduce: {outbounds, terminals} do
        {outbounds, terminals} ->
          out_neighbors = MapSet.delete(outbounds[v1], v2)
          terminals = if(Enum.empty?(out_neighbors), do: [v1 | terminals], else: terminals)
          {Map.put(outbounds, v1, out_neighbors), terminals}
      end

    {Map.delete(inbounds, v2), outbounds, terminals}
  end
end
