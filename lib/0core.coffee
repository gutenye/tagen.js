Tagen = {}
Tagen.VERSION = '0.0.1'
root = this.root = this


if exports?
  exports.Tagen = Tagen 
  exports.pd = pd
else
  root['Tagen'] = Tagen
  root['pd'] = pd

##
## Util function
##


# reopen a Class or a <#Object>
#
# use Object.defineProperty
#
Tagen.reopen = Tagen.mixin = (object, attrs) ->
  object = object.prototype if object.prototype

  for own k, v of attrs
    Object.defineProperty(object, k, value: v)

# reopenClass a Class
Tagen.reopenClass = (klass, attrs) ->
  for k, v of attrs
    continue if attrs.hasOwnProperty(k)
    klass[k] = v

# Extend a given object with all the properties in passed-in object(s).
Tagen.extend = (obj, args...) ->
  args.each (source) ->
    for prop of source
      obj[prop] = source[prop]
  return obj

# Generate a unique integer id (unique within the entire client session).
idCounter = 0
Tagen.uniqueId = (prefix) ->
  id = idCounter++
  if prefix then "#{prefix}#{id}" : "#{id}"


# Escape a string for HTML interpolation.
Tagen.escape = (string) ->
  (''+string).replace(/&(?!\w+;|#\d+;|#x[\da-f]+;)/gi, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#x27;').replace(/\//g,'&#x2F;')

# Generate an integer Array containing an arithmetic progression. A port of
# the native Python `range()` function. See
# [the Python documentation](http://docs.python.org/library/functions.html#range).
Tagen.range = (start, stop, step) ->
  if (arguments.length <= 1) 
    stop = start || 0
    start = 0
  step = arguments[2] || 1

  len = Math.max(Math.ceil((stop - start) / step), 0)
  idx = 0
  range = new Array(len)

  while (idx < len) 
    range[idx++] = start
    start += step

  return range

# Perform a deep comparison to check if two objects are equal.
Tagen.isEqual = (a, b) ->
  eq(a, b, [])

# Internal recursive comparison function.
eq = (a, b, stack) ->
  # Identical objects are equal. `0 === -0`, but they aren't identical.
  # See the Harmony `egal` proposal: http://wiki.ecmascript.org/doku.php?id=harmony:egal.
  return a != 0 || 1 / a == 1 / b if a == b
  # A strict comparison is necessary because `null == undefined`.
  return a == b if (a == null) || (b == null)
  # Invoke a custom `isEqual` method if one is provided.
  return a.isEqual(b) if a.isEqual.instanceOf(Function)
  return b.isEqual(a) if b.isEqual.instanceOf(Function)
  # Compare object types.
  typeA = typeof a
  return false if (typeA != typeof b)
  # Optimization; ensure that both values are truthy or falsy.
  return false if (!a != !b)
  # `NaN` values are equal.
  return b.isNaN() if a.isNaN()
  # Compare string objects by value.
  [ isStringA, isStringB ] = [ a.instanceOf(String), b.instanceOf(String) ]
  return isStringA && isStringB && String(a) == String(b) if (isStringA || isStringB) 
  # Compare number objects by value.
  [ isNumberA, isNumberB ] = [ a.instanceOf(Number), b.instanceOf(Number) ]
  return isNumberA && isNumberB && +a == +b if (isNumberA || isNumberB) 
  # Compare boolean objects by value. The value of `true` is 1; the value of `false` is 0.
  [ isBooleanA, isBooleanB ] = [ a.instanceOf(Boolean), b.instanceOf(Boolean) ]
  return isBooleanA && isBooleanB && +a == +b if (isBooleanA || isBooleanB) 
  # Compare dates by their millisecond values.
  [ isDateA, isDateB ] = [ a.instanceOf(Date), b.instanceOf(Date) ]
  return isDateA && isDateB && a.getTime() == b.getTime() if (isDateA || isDateB) 
  # Compare RegExps by their source patterns and flags.
  [ isRegExpA, isRegExpB ] = [ a.instanceOf(RegExp), b.instanceOf(RegExp) ]
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
  return false if (a.length !== b.length)
  # Objects with different constructors are not equal.
  return false if (a.constructor !== b.constructor)
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


