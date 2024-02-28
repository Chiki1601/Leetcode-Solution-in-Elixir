defmodule Solution do
  @spec find_bottom_left_value(root :: TreeNode.t() | nil) :: integer
  def find_bottom_left_value(root) do
    {:ok, pid} = Agent.start_link(fn -> nil end)
    bfs(:queue.from_list([root]), &Agent.update(pid, fn _ -> &1 end))
    Agent.get(pid, & &1)
  end

  defp bfs(q, f) do
    with {{:value, n}, nq} <- :queue.out(q), do: update_queue(nq, f, n)
  end

  defp update_queue(q, f, %TreeNode{val: v, left: l, right: r}) do
    f.(v)
    :queue.in(r, q) |> then(&:queue.in(l, &1)) |> bfs(f)
  end

  defp update_queue(q, f, nil), do: bfs(q, f)
end
