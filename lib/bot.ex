defmodule Botixir.Bot do
	use GenServer

	def start_link(state) do
		GenServer.start_link(__MODULE__, state)
	end

	def init(state) do
		{:ok, sock} = Socket.TCP.connect(state.host, state.port, packet: :line)
		{:ok, %{state | sock: sock}, 0}
	end

	def handle_info(:timeout, state) do
		# We are using the pipe operator (|>) here.
		# Without the pipe operator, we would have to write:
		# do_listen(do_join_channel(state))
		state |> do_join_channel |> do_listen
		{:noreply, state}
	end

	defp do_join_channel(%{sock: sock} = state) do
		sock |> Socket.Stream.send!("NICK #{state.nick}\r\n")
		sock |> Socket.Stream.send!("USER #{state.nick} #{state.host} #{state.nick} #{state.nick}\r\n")
		sock |> Socket.Stream.send!("JOIN #{state.chan}\r\n")
		state
	end

	defp do_listen(%{sock: sock} = state) do
		case state.sock |> Socket.Stream.recv! do
			data when is_binary(data) ->
				IO.inspect data
				do_listen(state)
				nil ->
					:ok
		end
	end
end