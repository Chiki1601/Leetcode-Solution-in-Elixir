defmodule Solution do
  @spec does_valid_array_exist(derived :: [integer]) :: boolean
  def does_valid_array_exist(derived) do
    0 === Enum.reduce(derived, 0, &Bitwise.bxor/2)
  end
end
