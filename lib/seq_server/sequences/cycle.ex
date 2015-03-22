defmodule SeqServer.Sequences.Cycle do
	@behaviour SeqServer.Sequence

	def start(from, to, inc \\ 1) do
		SeqServer.start_link(__MODULE__, [from, to, inc])
	end

	def init([from, to, inc]) do
		start = from
		max = to - from
		{0, start, max, inc}
	end

	def reset({_value, start, max, inc}) do
		{0, start, max, inc}
	end

	def next({current, start, max, inc}) do
		{current + start, {rem(current + inc, max + 1), start, max, inc}}
	end
end
