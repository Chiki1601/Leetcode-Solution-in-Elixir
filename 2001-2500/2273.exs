defmodule Solution do
  @spec remove_anagrams(words :: [String.t]) :: [String.t]
  def remove_anagrams(words) do
    Enum.dedup_by(words, fn s ->
      String.to_charlist(s)
      |> Enum.frequencies()
    end)
  end
end
