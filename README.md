# Glowstone

This tiny gem implements the [GameSpy query protocol](http://int64.org/docs/gamestat-protocols/gamespy2.html) to access pertinent real-time information hidden away inside your Minecraft server. You give Glowstone your server info, and Glowstone gives you:
- which players are currently online
- the base map name and default gamemode
- what plugins you're running
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

Glowstone's interface is super simple.  Just instantiate yourself a new server object, like so:

```ruby
my_server = Glowstone::Server.new "minecraft.tomheinan.com"
```

... and Glowstone will whip you up a server object full of all that delicious realtime data you've been craving:

```ruby
=> #<Glowstone::Server:0x007ffe250099b8 @host="minecraft.tomheinan.com", @port=25565, @timeout=3, @socket=#<UDPSocket:fd 8>, @motd="Welcome to Arkenfall!", @gamemode="SMP", @version="1.2.5", @plugins=["CraftBukkit on Bukkit 1.2.5-R4.1-MCPC-SNAPSHOT: mod_MinecraftForge ForgeMod", "AdminCmd 6.0.1 (BUILD 01.06.2012 @ 10:41:06)", "WorldEdit 5.3", "ExtraBiomes XL ForgeMod", "WorldGuard 5.5.3", "PermissionsBukkit 1.6"], @map_name="arkenfall", @num_players=1, @max_players=16, @players=["tomheinan"]>
```

And that's all there is to it!  No fancy bukkit plugins or server-side scripts required.  If your server object is particularly long-lived and you find yourself wanting to refresh its data, just do `my_server.refresh` and it'll pull down the latest information for you.

## Troubleshooting

**Help! I'm not receiving any data!**

The first thing to do is make sure your server is set up to send it.  Check your `server.properties` file and make sure the `enable-query` flag is set to `true`. Then, make sure your server's firewall allows connections on UDP port `25565`.  If you've changed that value via the `query.port` flag, then you'll also need to specify it when instantiating Glowstone, like so:

```ruby
my_server = Glowstone::Server.new("myminecraftserver.com", 12345)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
