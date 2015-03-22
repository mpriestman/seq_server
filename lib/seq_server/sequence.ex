defmodule SeqServer.Sequence do
	use Behaviour

	@type state :: tuple

	defcallback init(args :: list) :: state

	defcallback reset(s :: state) :: state

	defcallback next(s :: state) :: {any, state}
end
