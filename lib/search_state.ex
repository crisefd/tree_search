defmodule TreeSearch.SearchState do
  alias TreeSearch.Tree
  alias TreeSearch.SearchConfig
  alias TreeSearch.SearchUtility

  @type item :: :blue_item | :red_item
  @type board :: SearchConfig.board
  @type tree :: Tree.t
  @type set :: MapSet.t
  @type t :: %__MODULE__{
    carrying: [item],
    tree: tree,
    board: board,
    visited: set,
    targets_orders: [[atom]],
    nodes_to_expand: [tree],
    solution: [path: [{integer, integer}], cost: integer]
  }

  @targets ~w(blue_item red_item blue_spot red_spot)a

  defstruct carrying: [],
            tree: nil,
            board: nil,
            visited: MapSet.new(),
            nodes_to_expand: [],
            solution: [path: [], cost: 0],
            targets_orders: SearchUtility.permute(@targets)

end
