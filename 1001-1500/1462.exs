defmodule Solution do
  @spec check_if_prerequisite(num_courses :: integer, prerequisites :: [[integer]], queries :: [[integer]]) :: [boolean]
  def check_if_prerequisite(num_courses, prerequisites, queries) do
    # Initialize outgoing edges
    outs = Enum.map(0..(num_courses - 1), fn _ -> [] end)

    # Populate indegrees and outgoing edges
    ins = Enum.reduce(prerequisites, Enum.concat([0], List.duplicate(0, num_courses - 1)), fn [course, prerequisite], acc ->
      List.update_at(acc, prerequisite, &(&1 + 1))
      outs = List.update_at(outs, course, fn lst -> [prerequisite | lst] end)
      acc
    end)

    # Populate prerequisite matrix
    matrix = Enum.map(0..(num_courses - 1), fn _ -> [] end)
    for i <- 0..(num_courses - 1), ins[i] == 0 and Enum.empty?(matrix[i]) do
      matrix = Enum.update_at(matrix, i, fn _ -> List.duplicate(false, num_courses) end)
      dfs(ins, outs, matrix, i)
    end

    # Populate answers
    Enum.map(queries, fn [course, prerequisite] ->
      Enum.at(matrix[course], prerequisite) == true
    end)
  end

  defp dfs(ins, outs, matrix, vertex) do
    Enum.each(outs[vertex], fn next_vertex ->
      if Enum.empty?(matrix[next_vertex]) do
        matrix = List.update_at(matrix, next_vertex, fn _ -> Enum.at(matrix, vertex) end)
      else
        matrix = merge_rows(Enum.at(matrix, next_vertex), Enum.at(matrix, vertex))
      end
      matrix = List.update_at(matrix, next_vertex, fn mat -> Enum.at(mat, vertex) = true end)
      if (ins[next_vertex] - 1) == 0 do
        dfs(ins, outs, matrix, next_vertex)
      end
    end)
  end

  defp merge_rows(target, source) do
    Enum.zip(target, source)
    |> Enum.map(fn {t, s} -> t or s end)
  end
end
