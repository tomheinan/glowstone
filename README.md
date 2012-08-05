# Glowstone

This tiny gem implements the Gamespy query protocol to access pertinent real-time information hidden away inside your Minecraft server. You give Glowstone your server address and port, and Glowstone gives you:
- which players are currently online
- the current map name and default gamemode
- what plugins you're currently running
- even more stuff you probably don't care about!

All credit goes to [Dinnerbone](http://dinnerbone.com/) for his [excellent post](http://dinnerbone.com/blog/2011/10/14/minecraft-19-has-rcon-and-query/) on the inner workings of the protocol.  Check out his Python implementation [here](https://github.com/Dinnerbone/mcstatus).

## Installation

Add this line to your application's Gemfile:

    gem 'glowstone'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glowstone

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
