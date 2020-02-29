defmodule TreeSearch.SearchUtility do
  alias TreeSearch.SearchConfig, as: Config
  @type board :: Config.board

  @spec permute([any]) :: [[any]]

  def permute([]), do: [[]]
	def permute(list) do
		for item  <- list, rest <- permute(list -- [item]) do
			[item | rest]
		end
  end

  @spec manhattan_distance({number, number}, {number, number}) :: number
  def manhattan_distance({x1, y1}, {x2, y2}) do
    abs((x1 - x2) + (y1 - y2))
  end


  @spec fetch_elements(board) :: map
  def fetch_elements(board) do
    for  {{x, y}, {element, _, _}}  <- board do
      {element, {x, y}}
    end
    |> Map.new
  end


end
