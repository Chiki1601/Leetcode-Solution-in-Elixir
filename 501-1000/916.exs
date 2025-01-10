defmodule Solution do
  @spec word_subsets(words1 :: [String.t], words2 :: [String.t]) :: [String.t]
  def word_subsets(words1, words2) do
    words1 = Stream.map(words1, &{&1, char_freqs(&1)})
    words2 = words2 |> Stream.map(&char_freqs/1) |> Enum.uniq()
    words1
    |> Stream.filter(fn {_, h1} ->
      Enum.all?(words2, &universal?(h1, &1))
    end)
    |> Enum.map(&elem(&1, 0))
  end
      
  defp char_freqs(word) do
    word
    |> :binary.bin_to_list()
    |> Enum.frequencies()
  end
      
  defp universal?(h1, h2) do
    Enum.all?(h2, fn {c, f2} ->
      Map.get(h1, c, 0) >= f2
    end)
  end
end
