require 'socket'

module Glowstone

	class Server

		attr_reader :host, :port
		attr_accessor :timeout
		attr_reader :motd, :gamemode, :version, :plugins, :map_name, :num_players, :max_players, :players

		def initialize(host="localhost", port=25565)
			@host = host
			@port = port
			@timeout = SOCKET_TIMEOUT

			@socket = UDPSocket.new
			@socket.connect(@host, @port)
			refresh
		end

		def refresh
			response = perform_request(MAGIC_BYTES + REQUEST_BYTE[:query] + CLIENT_ID + get_session_id + CLIENT_ID)
			status = StatusPacket.read response

			@motd = status.motd
			@gamemode = status.gametype
			@version = status.version
			@plugins = status.plugins.split(/;\s*/)
			@map_name = status.map_name
			@num_players = status.num_players.to_i
			@max_players = status.max_players.to_i
			@players = status.players

			self
		end

		def to_hash
			vars_to_skip = ["@timeout", "@socket"]

			hash = Hash.new
			instance_variables.each do |var|
				hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) unless vars_to_skip.include?(var.to_s)
			end
			hash
		end

		protected ##################### helper methods and other such shenanigans #

		def get_session_id
			response = perform_request(MAGIC_BYTES + REQUEST_BYTE[:challenge] + CLIENT_ID)
			
			# the challenge token comes back as a series of bytes that represent the
			# integer we want, so we have to convert it to the actual 32bit int
			[response.slice(5..-2).to_i].pack("l>").bytes.to_a
		end

		def perform_request(request)
			@socket.send(request.pack("c*"), 0)
			packet = if select([@socket], nil, nil, @timeout)
				@socket.recvfrom(2048)
			end
			raise SocketError if packet == nil
			packet.first
		end

	end

end
