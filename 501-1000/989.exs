defmodule Solution do
    @spec add_to_array_form(num :: [integer], k :: integer) :: [integer]
    def add_to_array_form(num, k),
      do: num |> Enum.reverse() |> add_to_array_form_recursive(k, false) |> Enum.reverse()

    defp add_to_array_form_recursive(num, 0, carry?),
      do: if(carry?, do: add_to_array_form_recursive(num, 1, false), else: num)

    defp add_to_array_form_recursive([], k, carry?) do
      sum = rem(k, 10) + if(carry?, do: 1, else: 0)
      new_k = div(k, 10)
      new_carry = sum >= 10
      new_num = rem(sum, 10)
      [new_num | add_to_array_form_recursive([], new_k, new_carry)]
    end

    defp add_to_array_form_recursive([h | t], k, carry?) do
      sum = h + rem(k, 10) + if(carry?, do: 1, else: 0)
      new_k = div(k, 10)
      new_carry = sum >= 10
      new_num = rem(sum, 10)
      [new_num | add_to_array_form_recursive(t, new_k, new_carry)]
    end
  end
