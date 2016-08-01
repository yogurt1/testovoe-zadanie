g = require 'gulp'
$ = do require 'gulp-load-plugins'
bs = require 'browser-sync'
sass = require 'gulp-sass'
{resolve} = require 'path'

f =
  styles: 'src/styles/index.sass'
  templates: 'src/templates/index.pug'
  dist: 'dist'
  plugins: [
    (require 'postcss-flexibility')
    (require 'postcss-cssnext') autoprefixer: @browsers, warnForDuplicates: off
    (require 'cssnano') autoprefixer: no
  ]
  browsers: [
    'ie >= 8',
    'ff >= 24',
    'android >= 4',
    'ios >= 7',
    'chrome >= 34'
  ]

g.task 'serve', ['build'], ->
  bs.init
    server: f.dist
    open: no
    tunnel: off
  g.watch 'src/styles/*', ['styles']
  g.watch 'src/templates/*', ['templates']

g.task 'styles', ->
  g.src f.styles
    .pipe do $.plumber
    .pipe $.sass includePaths: resolve './src/styles/'
    .pipe do $.sourcemaps.init
    .pipe $.rename 'styles.css'
    .pipe $.postcss f.plugins
    .pipe $.sourcemaps.write '.'
    .pipe g.dest f.dist
    .pipe do bs.stream

g.task 'templates', ->
  g.src f.templates
    .pipe do $.plumber
    .pipe do $.pug
    .pipe g.dest f.dist
    .pipe do bs.stream

g.task 'build', [
  'styles',
  'templates'
]

g.task 'default', [
  'build',
  'serve'
]
