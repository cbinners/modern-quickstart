window.React = require 'react/addons'
window.$ = require 'jquery'

# React Router
Router = require 'react-router'
window.Router         = Router
window.DefaultRoute   = Router.DefaultRoute
window.Route          = Router.Route
window.Handler        = Router.RouteHandler

# React Router configuration
routes = require 'routes'

Router.run routes, Router.HistoryLocation, (Handler) ->
  React.render <Handler flux={window.flux}/>, document.getElementById("app")
