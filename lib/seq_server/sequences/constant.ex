defmodule SeqServer.Sequences.Constant do
	@behaviour SeqServer.Sequence

	def start(value), do: SeqServer.start_link(__MODULE__, [value])

	def init([value]), do: {value}

	def reset(state), do:	state

	def next({value} = state), do: {value, state}
end
