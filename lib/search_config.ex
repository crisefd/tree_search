defmodule TreeSearch.SearchConfig do
  @type item :: :free | :hard | :robot | :blue_item | :red_item | :blue_spot | :red_spot
  @type cell :: {item, integer, integer}

  @type t :: %__MODULE__{
   elements_map: map,
   board: %{required(tuple) => cell},
   weigths: [free: integer,
             hard: integer,
             robot: integer,
             blue_item: integer,
             red_item: integer,
             blue_spot: integer,
             red_spot: integer]
  }

  @moves ~w(up down left right)a

  defstruct board: %{},
            elements_map: %{},
            weigths: [hard:     nil,
                      free:       0,
                      robot:     -1,
                      blue_item: -2,
                      red_item:  -3,
                      blue_spot: -4,
                      red_spot:  -5]

  @spec moves :: [:down | :left | :right | :up, ...]
  def moves, do: @moves

end
