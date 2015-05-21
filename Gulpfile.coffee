gulp =            require 'gulp'
coffee =          require 'gulp-coffee'
concat =          require 'gulp-concat'
gutil =           require 'gulp-util'
sass =            require 'gulp-sass'
filter =          require 'gulp-filter'
del =             require 'del'
browserify =      require 'browserify'
watchify =        require 'watchify'
source =          require 'vinyl-source-stream'
nodemon =         require 'gulp-nodemon'
transform =       require 'vinyl-transform'

# PATH CONFIGURATION

paths =
  public:         './public'
  scripts:        './client'
  assets:         './client/assets/**'
  styles:         './client/styles/**'

files =
  app:
    js:           'application.js'

# BROWSERIFY CONFIGURATION

args = watchify.args
args.extensions = ['.coffee', '.cjsx']
args.paths = ["./client", "."]

bundler = watchify(browserify paths.scripts + '/application.cjsx', args)
bundler.transform 'coffee-reactify'

bundle = ->
  bundler.bundle()
    .on 'error', gutil.log.bind(gutil, 'Browserify Error')
    .pipe source(files.app.js)
    .pipe gulp.dest(paths.public)

bundler.on 'update', bundle

# GULP TASKS

gulp.task 'scripts', ->
  bundle()

gulp.task 'sass', ->
  gulp.src "#{paths.styles}/app.scss"
    .pipe sass({errLogToConsole: true})
    .pipe gulp.dest(paths.public)

gulp.task 'assets', ->
  gulp.src paths.assets
    .pipe gulp.dest(paths.public)

gulp.task 'watch', ->
  gulp.watch paths.scripts, ['scripts']
  gulp.watch paths.assets, ['assets']
  gulp.watch paths.styles, ['sass']

gulp.task 'run', [
  'watch'
  'assets'
  'scripts'
  'sass'
]

gulp.task 'server', ->
  nodemon( script: 'server/index.coffee')
    .on 'restart', ->
      console.log "Server restarted"

gulp.task 'default', [
  'run'
  'server'
]
