defmodule SeqServerTest do
  use ExUnit.Case

	test "next number" do
		{:ok, seq} = SeqServer.start_link(SeqServer.Sequences.Constant, [42])
		assert SeqServer.next(seq) == 42
		assert SeqServer.next(seq) == 42
		assert SeqServer.next(seq) == 42
		:ok = SeqServer.terminate(seq)
	end

	test "reset sequencce" do
		{:ok, seq} = SeqServer.start_link(SeqServer.Sequences.Monotonic, [42])
		assert SeqServer.next(seq) == 42
		assert SeqServer.next(seq) == 43
		assert SeqServer.next(seq) == 44
		assert SeqServer.reset(seq) == :ok
		assert SeqServer.next(seq) == 42
		assert SeqServer.next(seq) == 43
		assert SeqServer.next(seq) == 44
		:ok = SeqServer.terminate(seq)
	end

	test "cycle sequence" do
		{:ok, seq} = SeqServer.start_link(SeqServer.Sequences.Cycle, [5, 10, 1])
		assert SeqServer.next(seq) == 5
		assert SeqServer.next(seq) == 6
		assert SeqServer.next(seq) == 7
		assert SeqServer.next(seq) == 8
		assert SeqServer.next(seq) == 9
		assert SeqServer.next(seq) == 10
		assert SeqServer.next(seq) == 5
		:ok = SeqServer.terminate(seq)
	end
end
