defmodule TreeSearch.Tree do

  @type t :: %__MODULE__{value: any, key: any, depth: integer, estimated_cost: integer, children: [t]}

  defstruct value: nil, key: nil, children: [], depth: nil, estimated_cost: nil

end
