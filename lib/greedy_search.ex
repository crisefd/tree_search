defmodule TreeSearch.GreedySearch do
  alias TreeSearch.SearchConfig, as: Config
  alias TreeSearch.SearchState, as: State
  alias TreeSearch.Tree
  alias TreeSearch.SearchUtility, as: Utility

  @type state :: SearchState.t
  @type tree :: Tree.t
  @type config :: SearchConfig.t
  @type cell :: SearchConfig.cell



  @spec run(config) :: any
  def run(config = %Config{board: initial_board, elements_map: elements_map}) do
    {x, y} = elements_map[:robot]
    root = %Tree{ value: {:robot, x, y}, key: {x, y}, depth: 0 }

    state = %State{board: initial_board}
  end

  def search(tree, state = %State{targets_orders: [permutation | permutations]}, config, elements_map) do
    for target_name <- permutation do
      target = elements_map[target_name]

    end
  end


  def do_search(tree = %Tree{children: []}, target, state, config) do
    new_tree = expand(tree, state, config, target)
    new_visited =
      Enum.reduce(new_tree,
                 state.visited,
                 fn(%Tree{value: value}, visited) ->
                    MapSet.put(visited, value)
                 end)

  end


  def expand(node = %Tree{value: {_, x, y}, depth: depth}, state = %State{board: board, visited: visited}, config, target) do
    new_depth = depth + 1
    children =
      for move <- Config.moves do
        position =
          case move do
            :left ->
              {x - 1, y}
            :right ->
              {x + 1, y}
            :up ->
              {x, y - 1}
            :down ->
              {x, y + 1}
          end
        cost = heuristic(position, target, state, config)
        board[position] |> new_node(position, new_depth, MapSet.member?(visited, position), cost)
      end
      |> Enum.filter(&(&1))
      %{ node | children: children }
  end

  @spec new_node(any, any, integer, boolean) :: nil | TreeSearch.Tree.t()
  def new_node(nil, _, _, _, _), do: nil

  def new_node(_, _, _, true, _), do: nil

  def new_node(value, key, depth, cost) do
    %Tree{value: value, key: key, depth: depth, estimated_cost: cost}
  end

  @spec heuristic(cell, cell, state, config) :: integer

  def heuristic(_current = {_, x1, y1},
                _target = {_, x2, y2},
                _state = %State{carrying: items},
                _config = %Config{weigths: weigths}) do
    distance = Utility.manhattan_distance({x1, y1}, {x2, y2})
    weigths_sum =
      Enum.reduce(items, 0, fn(item, result) ->
        result + weigths[item]
      end)
     case weigths_sum do
        0 -> distance
        _ -> distance * weigths_sum
     end



  def tree_insert_helper(tree_stack, new_tree) do
    i =
      Enum.find_index(tree_stack, fn(tree) ->
        new_tree.estimated_cost <= tree.estimated_cost
      end)
    Enum.take(tree_stack, i + 1) ++
    [new_tree] ++
    Enum.slice(tree_stack, i..-1)
  end


end
