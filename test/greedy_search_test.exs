defmodule GreedySearchTest do
  alias TreeSearch.{GreedySearch, SearchConfig, SearchState}
  use ExUnit.Case

  test "heuristic works" do
    target = {:blue_item, 9, 9}
    current = {:free, 1, 1}
    config = %SearchConfig{}
    state = %SearchState{carrying: [:red_item]}
    assert GreedySearch.heuristic(current, target, state, config) == -48

    target = {:free, 9, 9}
    state = %SearchState{carrying: [:red_item, :blue_item]}

    assert  GreedySearch.heuristic(current, target, state, config) == -80

    state = %SearchState{carrying: []}
    assert GreedySearch.heuristic(current, target, state, config) == 16

  end
end
