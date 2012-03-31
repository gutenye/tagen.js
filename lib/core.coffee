_ = (obj) -> new Wrapper(obj)

_.VERSION = '0.0.1'
BREAKER = new Error('BREAKER')
root = this.root = this

if exports? then exports = _ else root['_'] = _
if global? then global['BREAKER'] = BREAKER else root['BREAKER'] = BREAKER

##
## Util function
##

# reopenClass(Class, attrs)
_.reopenClass = (klass, attrs, overwrite) ->
  for own k, v of attrs
    unless klass[k]
      Object.defineProperty(klass, k, value: v, writable: true)

# reopen(Class, attrs, overwrite=false)
# @overwrite. false use native method if possible.
#
# see Object#reopen
#
# alias mixin
_.reopen = _.mixin = (klass, attrs, overwrite) ->
  target = klass.prototype
  for own k, v of attrs
    if target[k] && !overwrite
      # pass
    else
      target[k] = v

_.try = (obj, method, args...) ->
  return null if obj == null
  return obj[method].call(obj, args...) if obj[method]
  return null

# Generate a unique integer id (unique within the entire client session).
idCounter = 0
# uniqueId([prefix])
# @return [String]
_.uniqueId = (prefix) ->
  id = idCounter++
  if prefix then "#{prefix}#{id}" else "#{id}"

# Escape a string for HTML interpolation.
_.escape = (str) ->
  str = str.toString()
  str.replace(/&(?!\w+;|#\d+;|#x[\da-f]+;)/gi, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#x27;').replace(/\//g,'&#x2F;')

# Perform a deep comparison to check if two objects are equal.
_.isEqual = (a, b) ->
  eq(a, b, [])

# Internal recursive comparison function.
eq = (a, b, stack) ->
  # Identical objects are equal. `0 === -0`, but they aren't identical.
  # See the Harmony `egal` proposal: http://wiki.ecmascript.org/doku.php?id=harmony:egal.
  return a != 0 || 1 / a == 1 / b if a == b
  # A strict comparison is necessary because `null == undefined`.
  return a == b if (a == null) || (b == null)
  # Invoke a custom `isEqual` method if one is provided.
  return a.isEqual(b) if a.isEqual && _(a.isEqual).instanceOf(Function)
  return b.isEqual(a) if b.isEqual && _(b.isEqual).instanceOf(Function)
  # Compare object types.
  typeA = typeof a
  return false if (typeA != typeof b)
  # Optimization; ensure that both values are truthy or falsy.
  return false if (!a != !b)
  # `NaN` values are equal.
  return _(b).isNaN() if _(a).isNaN()
  # Compare string objects by value.
  [ isStringA, isStringB ] = [ _(a).instanceOf(String), _(b).instanceOf(String) ]
  return isStringA && isStringB && String(a) == String(b) if (isStringA || isStringB) 
  # Compare number objects by value.
  [ isNumberA, isNumberB ] = [ _(a).instanceOf(Number), _(b).instanceOf(Number) ]
  return isNumberA && isNumberB && +a == +b if (isNumberA || isNumberB) 
  # Compare boolean objects by value. The value of `true` is 1; the value of `false` is 0.
  [ isBooleanA, isBooleanB ] = [ _(a).instanceOf(Boolean), _(b).instanceOf(Boolean) ]
  return isBooleanA && isBooleanB && +a == +b if (isBooleanA || isBooleanB) 
  # Compare dates by their millisecond values.
  [ isDateA, isDateB ] = [ _(a).instanceOf(Date), _(b).instanceOf(Date) ]
  return isDateA && isDateB && a.getTime() == b.getTime() if (isDateA || isDateB) 
  # Compare RegExps by their source patterns and flags.
  [ isRegExpA, isRegExpB ] = [ _(a).instanceOf(RegExp), _(b).instanceOf(RegExp) ]
  if (isRegExpA || isRegExpB) 
    # Ensure commutative equality for RegExps.
    return isRegExpA && isRegExpB &&
           a.source == b.source &&
           a.global == b.global &&
           a.multiline == b.multiline &&
           a.ignoreCase == b.ignoreCase
  
  # Ensure that both values are objects.
  return false if (typeA != 'object')
  # Arrays or Arraylikes with different lengths are not equal.
  return false if (a.length != b.length)
  # Objects with different constructors are not equal.
  return false if (a.constructor != b.constructor)
  # Assume equality for cyclic structures. The algorithm for detecting cyclic
  # structures is adapted from ES 5.1 section 15.12.3, abstract operation `JO`.
  length = stack.length
  while (length--) 
    # Linear search. Performance is inversely proportional to the number of unique nested structures.
    return true if (stack[length] == a) 
  
  # Add the first object to the stack of traversed objects.
  stack.push(a)
  [ size, result ] = [ 0, true ]
  # Deep compare objects.
  for own key of a
    # Count the expected number of properties.
    size++;
    # Deep compare each member.
    break if (!(result = hasOwnProperty.call(b, key) && eq(a[key], b[key], stack))) 

  # Ensure that both objects contain the same number of properties.
  if (result) 
    for key of b
      break if (hasOwnProperty.call(b, key) && !size--)
    result = !size

  # Remove the first object from the stack of traversed objects.
  stack.pop()
  return result


class Wrapper
  constructor: (obj) ->
    @object = obj
   
  reopen: (attrs) ->
    for own k, v of attrs
      @object[k] = v

  # http://stackoverflow.com/questions/332422/how-do-i-get-the-name-of-an-objects-type-in-javascript
  constructorName: ->
    if Object::toString.call(@object) == '[object Arguments]'
      'Arguments'
    else
      results = @object.constructor.toString().match(/function (.{1,})\(/)
      if results && results.length > 1 then results[1] else ''

  # 1.instanceOf(Number) => true
  #
  # arguments.instanceOf('Arguments') => true # arguments is special
  instanceOf: (constructorClass)->
    if constructorClass == 'Arguments' &&  Object::toString.call(@object) == '[object Arguments]'
      true
    else
      @object.constructor == constructorClass

  isNaN: ->
    @object != @object

  # Invokes interceptor with the obj, and then returns obj.
  # The primary purpose of this method is to "tap into" a method chain, in
  # order to perform operations on intermediate results within the chain.
  tap: (interceptor) ->
    interceptor(@object)
    return this

  # Create a (shallow-cloned) duplicate of an object.
  clone: () ->
    ret = {}
    for prop of @object
      ret[prop] = @object[prop]
    ret

  # Return a sorted list of the function names available on the object.
  methods: () ->
    names = []
    for k, v of @object
      names.push(k) if _(v).instanceOf(Function)
    return names.sort()

# alias #foo to #_foo
_.under_alias = (klass, names...) ->
  for name in names
    under_name = "_#{name}"
    klass.prototype[under_name] = klass.prototype[name]

# Expose `wrapper.prototype` as `_.prototype`
_.prototype = Wrapper.prototype
