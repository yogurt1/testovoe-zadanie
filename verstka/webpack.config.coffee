# coffeelint: disable=max_line_length
webpack = require 'webpack'
{join, resolve} = require 'path'
extend = require 'lodash/extend'
fs = require 'fs'
publicPath = 'dist'

#merge = require 'webpack-merge'
ExtractTextPlugin = require 'extract-text-webpack-plugin'
#ProgressBarPlugin = require 'progress-bar-webpack-plugin'
HtmlPlugin = require 'html-webpack-plugin'
OfflinePlugin = require 'offline-plugin'

styles =
  plugin: new ExtractTextPlugin filename: 'styles.css', allChunks: on
  extract: (loader) -> if production then @plugin.extract {fallbackLoader: 'style', loader} else "style!#{loader}"
  common: 'css?minimize&sourceMap&importLoaders=1'
  sass: -> @common + '!postcss!sass?sourceMap'
  css: -> @common + '!postcss'

{NODE_ENV} = process.env
production = NODE_ENV is 'production'
watch = NODE_ENV is 'watch'

# Plugins
plugins =
  common: [
    new webpack.DefinePlugin
      "process.env.NODE_ENV": JSON.stringify NODE_ENV
      "NODE_ENV": JSON.stringify NODE_ENV
      "production": JSON.stringify production
      "__DEV__": JSON.stringify production
  ]
  development: [
    new webpack.HotModuleReplacementPlugin
  ]
  production: [
    new webpack.optimize.DedupePlugin
    new webpack.optimize.AggressiveMergingPlugin,
    #new webpack.optimize.OccurenceOrderPlugin,
    new webpack.optimize.UglifyJsPlugin
      compress:
        warnings: off
        drop_console: on
        unsafe: on
      mangle: on
      #screw_ie8: on
      sourceMap: on
    new OfflinePlugin
      AppCache:
        publicPath: 'dist'
        directory: ''
      ServiceWorker: off
  ]
  devserver: [
    "webpack-dev-server/client?http://localhost:3000"
    "webpack/hot/only-dev-server"
  ]
  postcss: [
    #require('autoprefixer')(['last 2 versions'])
    require 'postcss-cssnext'
    require 'postcss-svgo'
    require 'postcss-circle'
    require 'postcss-center'
    require 'postcss-animation'
    require 'postcss-triangle'
    require 'postcss-instagram'
  ].concat if not production then [] else [
    require 'postcss-xcom-styleguide'
  ]
  #expose: [{
  #  test: require.resolve 'react'
  #  loader: 'expose?React'
  #},{
  #  test: require.resolve 'redux'
  #  loader: 'expose?Redux'
  #}]

#reacthot = if production then [] else ['react-hot']

# Loaders
loaders = [{
  test: /\.(js|jsx)$/
  loades: 'babel-loader'
  include: resolve __dirname, './src'
  query: presets: ['es2015', 'stage-0']
  exclude: /node_modules/
},{
  test: /\.coffee$/
  loader: 'coffee'
  exclude: /node_modules/
},{
  test: /\.cson$/
  loader: 'cson'
},{
  test: /\.(pug|jade)$/
  loader: 'pug?static'
},{
  test: /\.html$/
  loader: 'html'
},{
  test: /\.(scss|sass)$/
  loader: styles.extract do styles.sass
},{
  test: /\.css$/
  loader: styles.extract do styles.css
},{
  test: /\.md$/
  loader: 'markdown'
#},{
#  test: /\.(png|jpg|ico|svg|eot|ttf|woff(2))/
#  loader: 'file?name=static/[name].[hash].[ext]'
},{
  test: /\.(eot|ttf|woff(2))$/
  loader: 'url?limit=100000&name=[name].[ext]'
},{
  test: /\.(png|jpg|jpeg|ico|svg|gif)$/
  loader: 'url?limit=100000&name=[name].[ext]!image-webpack?optimizationLevel=9'
}]
  
config =
  name: 'Guestbook'
  target: 'web'
  entry:
    bundle: [
      'flexboxgrid'
      './src/index'
      './src/styles/index'
    ].concat if not production then plugins.devserver else []
    #vendor: []
  devtool: if production then 'source-map' else 'eval-source-map'
  devServer:
    #publicPath: ''
    hot: on
    inline: on
    stats: 'error-only'
    contentBase: ''
    historyApiFallback: off
    colors: on
    noInfo: off
    progress: yes
    port: 3000
  debug: off #production
  postcss: -> plugins.postcss
  sassLoader:
    includePath: [resolve __dirname, './node_modules']
  output:
    path: resolve './dist'
    #publicPath: 'dist'
    filename: '[name].js'
    chunkFilename: '[name].js'
    sourcemapFilename: '[name].map'
    libraryTarget: "umd"
  resolve:
    extensions: ['', '.js', '.cjsx', '.coffee', '.cson', '.sass', '.css', '.jade']
    alias:
      'templates': resolve './src/templates/'
      'styles': resolve './src/styles'
      'lib': resolve './src/lib'
      'images': resolve './src/images'
      'fonts': resolve './src/fonts'
  module: {loaders}
  plugins: [
    plugins.common...
    styles.plugin
    new webpack.optimize.CommonsChunkPlugin
      name: 'common'
      filename: '[name].js'
    new HtmlPlugin
      #template: './src/index.html.coffee'
      template: './src/templates/index.pug'
      cache: yes
      #publicPath: ''
      filename: if production or watch then resolve 'index.html' else 'index.html'
      hash: yes
    #plugins[if production and not watch then 'production' else 'development']...
  ].concat if watch then [] else plugins[if production then 'production' else 'development']

module.exports = config
