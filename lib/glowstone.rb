require "glowstone/version"
require "glowstone/server"
require "glowstone/packets"

module Glowstone

	MAGIC_BYTES    = [0xFE, 0xFD]
	REQUEST_BYTE   = {:challenge => [0x09], :query => [0x00]}
	CLIENT_ID      = [0x67, 0x6C, 0x6F, 0x77]
	SOCKET_TIMEOUT = 3 # seconds

end
