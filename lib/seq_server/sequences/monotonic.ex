defmodule SeqServer.Sequences.Monotonic do
	@behaviour SeqServer.Sequence

	def start(initial), do: SeqServer.start_link(__MODULE__, [initial])

	def init([initial]), do: {initial, initial}

	def reset({_value, initial}), do:	{initial, initial}

	def next({value, initial}), do:	{value, {value + 1, initial}}
end
