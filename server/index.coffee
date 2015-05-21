# Load express modules
http = require 'http'
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
session = require 'express-session'

start = ->
  app = express()
  app.use bodyParser()
  app.use cookieParser()
  app.use session(secret: "mongood-21E6B96F-FDC0-4779-890D-804602DF2E71")
  app.use express.static("public")
  http.createServer(app).listen(3000)

if require.main is module
  start()
else
  module.exports =
    start: start
