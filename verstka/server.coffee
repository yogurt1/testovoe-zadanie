webpack = require 'webpack'
server = require 'webpack-dev-server'
config = require './webpack.config'

{port = 3000, host = 'localhost'} = config.devServer

new server webpack(config), config.devServer
  .listen port, host
