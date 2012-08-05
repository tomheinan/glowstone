require 'bindata'

class StatusPacket < BinData::Record
	endian :big

	int8 :request_type
	string :client_id, :length => 4

	skip :length => 9 # "splitnum\0"
	uint8 :world_height # maybe?
	skip :length => 10 # "\0hostname\0"
	stringz :motd
	skip :length => 9 # "gametype\0"
	stringz :gametype
	skip :length => 26 # "game_id\0MINECRAFT\0version\0"
	stringz :version
	skip :length => 8 # "plugins\0"
	stringz :plugins
	skip :length => 4 # "map\0"
	stringz :map_name
	skip :length => 11 # "numplayers\0"
	stringz :num_players
	skip :length => 11 # "maxplayers\0"
	stringz :max_players
	skip :length => 9 # "hostport\0"
	stringz :port
	stringz :host_label
	stringz :host
	int8 :na1
	int8 :na2
	stringz :na3
	skip :length => 1
	array :players, :type => :stringz, :initial_length => lambda { num_players.to_i }

end
