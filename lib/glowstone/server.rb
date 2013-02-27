require 'resolv'
require 'socket'

module Glowstone

	class Server

		attr_reader :host, :port
		attr_accessor :timeout
		attr_reader :motd, :gamemode, :version, :plugins, :map_name, :num_players, :max_players, :players

		def initialize(host="localhost", options={})
			
			# backwards compatibility for old style invocation
			if options.is_a?(Numeric)
				options = {:port => options.to_i}
			end

			# if the host is a srv record, get its info
			begin
				resource = Resolv::DNS.new.getresource("_minecraft._tcp.#{host}", Resolv::DNS::Resource::IN::SRV)
				@host = resource.target.to_s
				@port = resource.port.to_i
			rescue
				@host = host
				@port = options[:port] ? options[:port].to_i : DEFAULT_PORT
			end

			# set request timeout
			@timeout = options[:timeout] ? options[:timeout].to_i : DEFAULT_SOCKET_TIMEOUT

			# create a reusable UDP socket
			@socket = UDPSocket.new
			@socket.connect(@host, @port)
			refresh
		end

		def refresh
			response = perform_request(MAGIC_BYTES + REQUEST_BYTE[:query] + CLIENT_ID + get_session_id + CLIENT_ID)
			status = StatusPacket.read response

			# there's some kind of weird bug with BinData wherein its native
			# datatypes don't play well with rails, so i'm converting them all here
			@motd = status.motd.to_s
			@gamemode = status.gametype.to_s
			@version = status.version.to_s

			@plugins = status.plugins.to_s.gsub!(/^(craft)?bukkit[^:]*:\s*/i, "").split(/;\s*/)
			@map_name = status.map_name.to_s
			@num_players = status.num_players.to_i
			@max_players = status.max_players.to_i

			player_array = status.players.to_ary
			player_array.each_with_index do |player, index|
				player_array[index] = player.to_s
			end
			@players = player_array

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
