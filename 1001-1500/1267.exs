defmodule Solution do
  @spec count_servers(grid :: [[integer]]) :: integer
  def count_servers(grid) do
    servers =
      for {row, i} <- Stream.with_index(grid),
          {1, j} <- Stream.with_index(row),
          into: MapSet.new(),
          do: {i, j}

    servers_by_row = Enum.frequencies_by(servers, &elem(&1, 0))
    servers_by_col = Enum.frequencies_by(servers, &elem(&1, 1))

    single_server_rows =
      servers_by_row
      |> Stream.filter(&elem(&1, 1) == 1)
      |> Enum.map(&elem(&1, 0))

    single_server_cols =
      servers_by_col
      |> Stream.filter(&elem(&1, 1) == 1)
      |> Enum.map(&elem(&1, 0))

    # There are false isolated servers (empty slots) in this result,
    # but it doesn't matter.
    possible_isolated_servers =
      for i <- single_server_rows,
          j <- single_server_cols,
          into: MapSet.new(),
          do: {i, j}

    servers
    |> MapSet.difference(possible_isolated_servers)
    |> MapSet.size()
  end
end
