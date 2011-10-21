# print with debug, easy for search.
#
# @example
#
#   pd 'inside coolFunc', this, arguments
#   search: grep 'pd ' -R lib 
#
# @param arguments
window.pd = ->
  pd.history ?= []
  pd.history.push arguments
  if this.console
    arguments.callee = arguments.callee.caller
    console.log( Array.prototype.slice.call(arguments) )

window.getInnerWidth = ->
  if window.innerWidth
    window.innerWidth
  else if document.body.clientWidth
    document.body.clientWidth
  else if document.documentElement.clientWidth
    document.documentElement.clientWidth

window.getInnerHeight = ->
  if window.innerHeight
    window.innerHeight
  else if document.body.clientHeight
    document.body.clientHeight
  else if document.documentElement.clientHeight
    document.documentElement.clientHeight
