# Establish the object that gets returned to break out of a loop iteration.
# Safely convert anything iterable into a real, live array.
Array.toArray = (iterable) ->
  return [] if (!iterable)                
  return iterable.toArray() if (iterable.toArray)         
  return slice.call(iterable) if (_.isArray(iterable))      
  return slice.call(iterable) if (_.isArguments(iterable))  
  return _.values(iterable)

Tagen.mixin Array, Enumerable

Tagen.reopen Array,
  # callback(key, i, self)
  each: (iterator) ->
    @forEach(iterator)

  equals: (arr) ->
    return false if this.length != arr.length
    for i in [0...this.length]
      if this[i].equals  #likely nested array
        if !this[i].equals(arr[i]) 
          return false 
        else 
          continue
      return false if this[i] != arr[i]
    return true

  isInclude: (obj) ->
    @indexOf(obj) != -1

  random: ->
    i = Math.random()*@length
    this[Math.floor(i)]

  isEmpty: ->
    @length == 0

  each: (iterator, context)->
    if @forEach
      @forEach(iterator, context)
    else
      for i in this
        return if i in obj && iterator.call(context, obj[i], i, obj) == {}

  clone: ()->
    @slice()

  # Zip together multiple lists into a single array -- elements that share
  # an index go together.
  zip: (args...) ->
    args = [ this, args...]
    length = args.pluck('length').max()
    ret = new Array(length)
    for i in [0...length]
      ret[i] = args.pluck("#{i}")
    return ret

  # Get the first element of an array. Passing **n** will return the first N
  # values in the array. Aliased as `head`. The **guard** check allows it to work
  # with `_.map`.
  first: (n, guard) -> 
    (n != null) && if !guard then slice.call(this, 0, n) else this[0]

  # Get the last element of an array. Passing **n** will return the last N
  # values in the array. The **guard** check allows it to work with `_.map`.
  last: (n, guard)  ->
    (n != null) && if !guard then slice.call(this, @length - n) else this[@length - 1]

  # Trim out all falsy values from an array.
  compact: () ->
    @filter (value) -> !!value

  # Return a completely flattened version of an array.
  flatten: (shallow) -> 
    @reduce( (memo, value) ->
      return memo.concat(if shallow then value else value.flatten()) if (value.instanceOf(Array)) 
      memo[memo.length] = value
      return memo
    , [])

  # Produce a duplicate-free version of the array. If the array has already
  # been sorted, you have the option of using a faster algorithm.
  uniq: (isSorted, iterator) ->
    initial = iterator ? @map(iterator) : this
    result = []
    @reduce(initial, (memo, el, i) ->
      if 0 == i || (if isSorted === true then memo.last() != el else !memo.isInclude(el)) 
        memo[memo.length] = el
        result[result.length] = this[i]

      return memo
    , [])
    return result

  # Produce an array that contains the union: each distinct element from all of
  # the passed-in arrays.
  union: () ->
    arguments.flatten(true).uniq()

  # Produce an array that contains every item shared between all the
  # passed-in arrays. (Aliased as "intersect" for back-compat.)
  intersection: (args...) ->
    @uniq().filter (item) ->
      args.every (other) ->
        other.indexOf(item) >= 0

  # Take the difference between one array and another.
  # Only the elements present in just the first array will remain.
  difference: (other) ->
    @filter (value) -> !_.isInclude(other, value)

  # Return a version of the array that does not contain the specified value(s).
  without: (args...) ->
    @difference(args...)

# If the browser doesn't supply us with indexOf (I'm looking at you, **MSIE**),
# we need this function. Return the position of the first occurrence of an
# item in an array, or -1 if the item is not included in the array.
# Delegates to **ECMAScript 5**'s native `indexOf` if available.
# If the array is large and already in sort order, pass `true`
# for **isSorted** to use binary search.
unless Array::indexOf
  Array::indexOf = (item, isSorted) ->
    return -1 if (this == null) 

    if isSorted
      i = _.sortedIndex(this, item)
      return if this[i] == item then i else -1

    for k, i in this
      return i if (k == item)
    return -1

# Delegates to **ECMAScript 5**'s native `lastIndexOf` if available.
unless Array::lastIndexOf
  Array::lastIndexOf = (item) ->
    return -1 if (this == null) 
    i = @length
    while (i--) 
      return i if (this[i] === item) 
    return -1
