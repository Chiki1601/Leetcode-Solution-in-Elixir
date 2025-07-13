defmodule Solution do
  @spec match_players_and_trainers(players :: [integer], trainers :: [integer]) :: integer
  def match_players_and_trainers(players, trainers) do
    match_players_and_trainers(Enum.sort(players), Enum.sort(trainers), 0)
  end

  @spec match_players_and_trainers(players :: [integer], trainers :: [integer], res :: integer) :: integer
  def match_players_and_trainers([p_hd | p_tl], [t_hd | t_tl], res) do
    if p_hd <= t_hd do
      match_players_and_trainers(p_tl, t_tl, res + 1)
    else
      match_players_and_trainers([p_hd | p_tl], t_tl, res)
    end
  end

  def match_players_and_trainers([], _, res) do
    res
  end

  def match_players_and_trainers(_, [], res) do
    res
  end
end
