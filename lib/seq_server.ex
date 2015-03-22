defmodule SeqServer do
	@moduledoc """
  A numerical sequence server.

  Each server provides numbers in a given sequence. A sequence
  is encoded via a module that conforms to the SeqServer.Sequence
  behaviour.

  The two basic functions are:

  * next number in a sequence
  * reset a sequence

  You can also terminate a sequence server when you no longer
  require it.
  """

	use GenServer

	@server __MODULE__

	##----------------------------------------
	## Client API
	##----------------------------------------

	@doc """
  Start a new sequence server with a given module and arguments.
  """
	@spec start_link(module, [term]) :: {:ok, pid}
	def start_link(module, args \\ []) do
		GenServer.start_link(@server, [module, args])
	end

	@doc """
  Returns the next number in the sequence.
  """
	@spec next(pid) :: any
	def next(pid) do
		GenServer.call(pid, :next)
	end

	@doc """
  Resets a sequence back to its original state.
  """
	@spec reset(pid) :: :ok
	def reset(pid) do
		GenServer.call(pid, :reset)
	end

	@doc """
  Terminates a sequence server.
  """
	@spec terminate(pid) :: :ok
	def terminate(pid) do
		GenServer.cast(pid, :terminate)
	end

	##----------------------------------------
	## GenServer callbacks
	##----------------------------------------

	def init([module, args]) do
		state = module.init(args)
		{:ok, {module, state}}
	end

	def handle_call(:next, _from, {module, state}) do
		{value, next_state} = module.next(state)
		{:reply, value, {module, next_state}}
	end

	def handle_call(:reset, _from, {module, state}) do
		new_state = module.reset(state)
		{:reply, :ok, {module, new_state}}
	end

	def handle_cast(:terminate, state) do
		{:stop, :normal, state}
	end

	def terminate(_reason, _state) do
		:ok
	end

	def code_change(_oldvsn, state, _extra) do
		{:ok, state}
	end

end
