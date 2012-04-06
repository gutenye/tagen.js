# Establish the object that gets returned to break out of a loop iteration.
# Safely convert anything iterable into a real, live array.
Array.toArray = (iterable) ->
  return [] if (!iterable)                
  return iterable.toArray() if (iterable.toArray)         
  return slice.call(iterable) if (_.isArray(iterable))      
  return slice.call(iterable) if (_.isArguments(iterable))  
  return _.values(iterable)

_.mixin Array, Enumerable

_.reopen Array,
  # each() => <#Enumerator>
  # each(iterator) => 
  #
  # support break by `throw BREAKER`
  #
  # callback(value, index, self)
  _each: (iterator) ->
    return new Enumerator(this) unless iterator

    try
      for v, i in this
        iterator(v, i, this)
    catch err
      throw err if err != BREAKER

  _isEqual: (ary) ->
    return false if @length != ary.length
    for v, i in this
      if _(v).instanceOf(Array) 
        return v._isEqual(ary[i]) 
      else
        return false if v != ary[i]
    return true

  # alias contains
  _isInclude: (obj) ->
    @indexOf(obj) != -1

  _isEmpty: ->
    @length == 0

  # shadow-clone
  _clone: ()->
    @slice()

  _random: ->
    i = Math.random() * @length
    this[Math.floor(i)]

  # Zip together multiple lists into a single array -- elements that share
  # an index go together.
  _zip: (args...) ->
    args = [ this, args...]
    length = args._pluck('length')._max()
    ret = new Array(length)
    for i in [0...length]
      ret[i] = args._pluck("#{i}")
    return ret

  # Get the first element of an array. Passing **n** will return the first N
  # values in the array
  #
  # first() => value
  # first(n) => Array
  _first: (n) ->
    if n then @slice(0, n) else this[0]

  # Get the last element of an array. Passing **n** will return the last N
  # values in the array
  #
  # last() => value
  # last(n) => Array
  _last: (n)  ->
    if n then @slice(@length-n) else this[@length-1]

  # Trim out all null values from an array.
  _compact: () ->
    @_findAll (value) -> 
      value != null

  # Return a completely flattened version of an array.
  #
  # flatten(shallow=false)
  _flatten: (shallow) -> 
    ret = []
    @_each (v) ->
      if _(v).instanceOf(Array)
        v = if shallow then v else v._flatten()
        ret = ret.concat v
      else
        ret.push v

    ret

  # Produce a duplicate-free version of the array. If the array has already
  # been sorted, you have the option of using a faster algorithm.
  #
  # uniq(isSorted=false)
  _uniq: (isSorted) ->
    ret = []

    @_each (v, i) ->
      if 0 == i || (if isSorted == true then ret._last() != v else !ret._isInclude(v)) 
        ret.push v
      ret

    return ret

  # Return a version of the array that does not contain the specified value(s).
  _without: (args...) ->
    @_findAll (value) -> !args._isInclude(value)

  # data like [ {a: 1}, {a: 2} .. ]
  #
  _pluck: (key) ->
    @_map (data) ->
      data[key]

  # findIndex(value)
  # findIndex(fn[v]=>bool)
  #
  # => -1
  _findIndex: (obj) ->
    switch _(obj).constructorName()
      when 'Function'
        iterator = obj
      else
        iterator = (v)->
          v == obj

    ret = -1
    @_each (v, i, self)->
      if iterator(v, i, self)
        ret = i
        throw BREAKER

    ret

  # Invoke a method (with arguments) on every item in a collection.
  # => null if no method
  _invoke: (methodName, args...) ->
    @_map (value) ->
      method = value[methodName]
      if method 
        method.apply(value, args...)
      else
        null

  # If the browser doesn't supply us with indexOf (I'm looking at you, **MSIE**),
  # we need this function. Return the position of the first occurrence of an
  # item in an array, or -1 if the item is not included in the array.
  # Delegates to **ECMAScript 5**'s native `indexOf` if available.
  # If the array is large and already in sort order, pass `true`
  # for **isSorted** to use binary search.
  _indexOf: Array::indexOf || (item, isSorted) ->
    return -1 if (this == null) 

    if isSorted
      i = _.sortedIndex(this, item)
      return if this[i] == item then i else -1

    for k, i in this
      return i if (k == item)
    return -1

  # Delegates to **ECMAScript 5**'s native `lastIndexOf` if available.
  _lastIndexOf: Array::lastIndexOf || (item) ->
    return -1 if (this == null) 
    i = @length
    while (i--) 
      return i if (this[i] == item) 
    return -1

  # [ [1,2], [3,4] ] => [ [1,3], [2,4] ]
  _transpose: ->
    w = @length
    h = if @[0] instanceof Array then @[0].length else 0
    return []  if h == 0 || w == 0

    ret = []
    i = 0
    while i < h
      ret[i] = []
      j = 0
      while j < w
        ret[i][j] = @[j][i]
        j++
      i++

    ret

# alias
Array::_contains = Array::_isInclude
_.under_alias Array, "push", "pop", "concat", "slice", "sort", "reverse", "join", "splice"
