defmodule Solution do
  @spec length_after_transformations(String.t(), integer, [integer]) :: integer
  def length_after_transformations(s, t, nums) do
    mod = 1_000_000_007
    alpha = 26

    base = init_matrix(alpha)
    base = apply_nums(base, nums, alpha)

    counts =
      s
      |> String.to_charlist()
      |> Enum.reduce(init_vector(alpha), fn ch, acc ->
        idx = ch - ?a
        put_elem(acc, idx, elem(acc, idx) + 1)
      end)

    power_mat = matrix_pow(base, t, mod, alpha)
    final_counts = multiply_vector(counts, power_mat, mod, alpha)

    Enum.reduce(0..(alpha - 1), 0, fn i, acc ->
      rem(acc + elem(final_counts, i), mod)
    end)
  end

  defp init_matrix(n) do
    Tuple.duplicate(init_vector(n), n)
  end

  defp init_vector(n), do: Tuple.duplicate(0, n)

  defp apply_nums(base, nums, alpha) do
    Enum.with_index(nums)
    |> Enum.reduce(base, fn {count, i}, acc ->
      Enum.reduce(1..count, acc, fn k, m ->
        j = rem(i + k, alpha)
        row = elem(m, i)
        new_row = put_elem(row, j, elem(row, j) + 1)
        put_elem(m, i, new_row)
      end)
    end)
  end

  defp matrix_mul(a, b, mod, alpha) do
    Tuple.duplicate(0, alpha)
    |> Tuple.duplicate(alpha)
    |> Tuple.to_list()
    |> Enum.with_index()
    |> Enum.map(fn {_, i} ->
      row =
        Enum.map(0..(alpha - 1), fn j ->
          Enum.reduce(0..(alpha - 1), 0, fn k, acc ->
            a_ik = elem(elem(a, i), k)
            b_kj = elem(elem(b, k), j)
            rem(acc + a_ik * b_kj, mod)
          end)
        end)

      List.to_tuple(row)
    end)
    |> List.to_tuple()
  end

  defp multiply_vector(vec, mat, mod, alpha) do
    Enum.map(0..(alpha - 1), fn j ->
      Enum.reduce(0..(alpha - 1), 0, fn i, acc ->
        rem(acc + elem(vec, i) * elem(elem(mat, i), j), mod)
      end)
    end)
    |> List.to_tuple()
  end

  defp matrix_pow(mat, 0, _mod, alpha), do: identity_matrix(alpha)

  defp matrix_pow(mat, exp, mod, alpha), do: pow_loop(mat, exp, identity_matrix(alpha), mod, alpha)

  defp pow_loop(_mat, 0, acc, _mod, _alpha), do: acc

  defp pow_loop(mat, exp, acc, mod, alpha) do
    acc = if rem(exp, 2) == 1, do: matrix_mul(acc, mat, mod, alpha), else: acc
    mat = matrix_mul(mat, mat, mod, alpha)
    pow_loop(mat, div(exp, 2), acc, mod, alpha)
  end

  defp identity_matrix(alpha) do
    Enum.map(0..(alpha - 1), fn i ->
      Enum.map(0..(alpha - 1), fn j -> if i == j, do: 1, else: 0 end)
      |> List.to_tuple()
    end)
    |> List.to_tuple()
  end
end
