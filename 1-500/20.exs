defmodule Solution do
  @valid_pairs [{"(", ")"}, {"[", "]"}, {"{", "}"}]

  defguard is_open_bracket(value) when value == "(" or value == "[" or value == "{"
  defguard is_closed_bracket(value) when value == ")" or value == "]" or value == "}"

  def is_valid(input_string) when is_binary(input_string) do
    input_string
    |> String.graphemes()
    |> check_is_valid([])
  end

  defp check_is_valid([head | tail] = input_chars, stack) when is_list(input_chars) and is_open_bracket(head) do
    stack = [head | stack]
    check_is_valid(tail, stack)
  end

  defp check_is_valid([head | tail] = input_chars, stack) when is_list(input_chars) and is_closed_bracket(head) do
    with true <- is_pair(List.first(stack), head) do
      stack = stack -- [List.first(stack)]
      check_is_valid(tail, stack)
    end
  end

  defp check_is_valid([], []), do: true
  defp check_is_valid([], _), do: false
  defp check_is_valid(_, _), do: false
  
  defp is_pair(left_p, right_p), do: Enum.member?(@valid_pairs, {left_p, right_p})
end
