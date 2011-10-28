Tagen = {}
Tagen.VERSION = '0.0.1'

root = this
root.pd = console.log
if exports? then exports.Tagen = Tagen else root['Tagen'] = Tagen

##
## Util function
##


# reopen a Class or a <#Object>
#
# use Object.defineProperty
#
Tagen.reopen = (object, attrs) ->
  object = object.prototype if object.prototype

  for own k, v of attrs
    Object.defineProperty(object, k, value: v)

# reopenClass a Class
Tagen.reopenClass = (klass, attrs) ->
  for k, v of attrs
    continue if attrs.hasOwnProperty(k)
    klass[k] = v
