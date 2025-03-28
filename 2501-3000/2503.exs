defmodule Solution do
  defmodule PQ do
    def new() do
      :gb_sets.new()
    end

    def push(pq, key, val) do
      :gb_sets.add_element({key, val}, pq)
    end

    def pop(pq) do
      {{key, val}, pq} = :gb_sets.take_smallest(pq)
      {key, val, pq}
    end

    def top(pq) do
      :gb_sets.smallest(pq)
    end
  end

  defmodule Grid do
    @behaviour Access

    defstruct data: {}

    def new(list_2d) do
      list_2d
      |> Enum.map(&List.to_tuple/1)
      |> List.to_tuple()
      |> then(&%__MODULE__{data: &1})
    end

    @impl Access
    def fetch(%__MODULE__{data: data}, coord) do
      do_fetch(data, coord)
    end

    defp do_fetch(data, {i, _}) when i < 0 or i >= tuple_size(data) do
      :error
    end

    defp do_fetch(data, {_, j}) when j < 0 or j >= tuple_size(elem(data, 0)) do
      :error
    end

    defp do_fetch(data, {i, j}) do
      data
      |> elem(i)
      |> elem(j)
      |> then(&{:ok, &1})
    end

    @impl Access
    def get_and_update(_, _, _) do
      raise RuntimeError, "Not implemented"
    end

    @impl Access
    def pop(_, _) do
      raise RuntimeError, "Not implemented"
    end
  end

  @spec max_points(grid :: [[integer]], queries :: [integer]) :: [integer]
  def max_points(grid, queries) do
    grid = Grid.new(grid)

    sorted_queries_with_index = queries |> Enum.with_index() |> Enum.sort_by(&elem(&1, 0))

    pq = PQ.new() |> PQ.push(grid[{0, 0}], {0, 0})
    visited = MapSet.new()

    sorted_queries_with_index
    |> Enum.map_reduce({pq, visited}, fn {query, i}, {pq, visited} ->
      {pq, visited} = pfs(grid, query, pq, visited)
      {{i, MapSet.size(visited)}, {pq, visited}}
    end)
    |> elem(0)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
  end

  @empty_pq PQ.new()

  defp pfs(_grid, _query, @empty_pq, visited) do
    {@empty_pq, visited}
  end

  defp pfs(grid, query, pq, visited) do
    {val, _} = PQ.top(pq)

    if query <= val do
      {pq, visited}
    else
      {_, {i, j} = coord, pq} = PQ.pop(pq)
      visited = MapSet.put(visited, coord)

      pq =
        for coord2 <- [{i - 1, j}, {i + 1, j}, {i, j - 1}, {i, j + 1}],
            val2 = grid[coord2],
            not MapSet.member?(visited, coord2),
            reduce: pq do
          pq -> PQ.push(pq, val2, coord2)
        end

      pfs(grid, query, pq, visited)
    end
  end
end
