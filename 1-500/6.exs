defmodule Solution do
  @spec convert(s :: String.t, num_rows :: integer) :: String.t
  def convert(s, 1) do
    # Special case: one row only, just return original string
    s
  end

  def convert(s, num_rows) do
    # Create a list of empty list to hold rows
    rows = for _i <- 0..num_rows-1 do
      []
    end

    # Split string into list and call helper function
    zigzag(String.split(s, "", trim: true), rows, num_rows)
  end

  defp zigzag(s, rows, num_rows, curr_row \\ 0, direction \\ 1)

  defp zigzag([], rows, _num_rows, _curr_row, _direction) do
    # Once we finish the string, reverse each row, concatenate each into a string
    # Then concatenate the list of strings into a string
    rows
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&List.to_string/1)
    |> List.to_string
  end

  defp zigzag([head|tail], rows, num_rows, curr_row, direction) do
    # Unpack rows, prepend the first character to the correct row, then repack
    prepended_rows = for {row, i} <- Enum.with_index(rows) do
      if i == curr_row do
        [head] ++ row
      else
        row
      end
    end

    # Determine if we need to change direction
    d = cond do
      curr_row + direction == num_rows -> -1
      curr_row + direction == -1 -> 1
      true -> direction
    end

    # Tail recursion
    zigzag(tail, prepended_rows, num_rows, curr_row+d, d)
  end
end
