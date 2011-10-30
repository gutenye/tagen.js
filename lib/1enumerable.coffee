Enumerable =
  # any?
  any: (iterator)->
    ret = false
    @each (args...)->
      if ret |= iterator(args...)
        return true
    return !!ret

  # all?
  all: (iterator)->
    ret = true
    @each (args...)->
      if !iterator(args...)
        ret = false 
        throw BREAKER
    return ret

  # none?
  none: (iterator)-> 
    ret = true
    @each (args...)->
      if iterator(args...)
        ret = false
        throw BREAKER
    return ret

  # one?
  one: (iterator)->
    counts = 0
    @each (args...)->
      if iterator(args...)
        counts += 1
        throw BREAKER if counts == 2
    return if counts == 1 then true else false

  map: (iterator) ->
    ret = []
    @each (args...) -> 
      ret.push iterator(args...)
    ret

  find: (iterator) ->
    ret = null
    @each (args...) =>
      if iterator(args...)
        ret = if @instanceOf(Object) then [args[0], args[1]] else args[0]
        throw BREAKER
    return ret

  findAll: (iterator) ->
    ret = []
    @each (args...) =>
      if iterator(args...)
        value = if @instanceOf(Object) then [args[0], args[1]] else args[0]
        ret.push value
    return ret

  # Return all the elements for which a truth test fails.
  # opsite of findAll.
  reject: (iterator) ->
    ret = []
    @each (args...) =>
      if !iterator(args...)
        value = if @instanceOf(Object) then [args[0], args[1]] else args[0]
        ret.push value
    return ret

  # inject(iterator)
  # inject(initial, iterator)
  #
  #  callback{|memo, args...| => memo}
  #
  # ONLY Array-like
  #
  inject: (args...) ->
    switch args.length
      when 1
        initial = null
        iterator = args[0]
      when 2
        initial = args[0]
        iterator = args[1]
      else
        throw 'wrong argument'

    memo = initial
    @each (args...) ->
      if initial == null
        memo = args[0]
        initial = true
      else
        memo = iterator(memo, args...)

    memo

  # Return the maximum element or (element-based computation).
  # ruby: max
  # max()
  # max(iterator)
  #
  # ONLY for Array-like
  #
  # => null, value
  max: () ->
    if @isEmpty() 
      return null
    else if @instanceOf(Array)
      return Math.max.apply(Math, this)

  # Return the minimum element (or element-based computation).
  # see max
  min: (iterator) ->
    if @isEmpty()
      return null
    else if @instanceOf(Array)
      return Math.min.apply(Math, this)

  # Shuffle an array.
  # only in Array ?
  shuffle: () ->
    [ shuffled, rand ] = [ [], null ]
    @each (value, index) ->
      if index == 0
        shuffled[0] = value
      else
        rand = Math.floor(Math.random() * (index + 1))
        shuffled[index] = shuffled[rand]
        shuffled[rand] = value
    return shuffled

  # Sort the object's values by a criterion produced by an iterator.
  # ONLY Array
  sortBy: (iterator) ->
    ret = (@map (args...) ->
      { value: args[0], criteria: iterator(args...) }
    ).sort((a, b) ->
      [ a, b ] = [ a.criteria, b.criteria ]
      if a < b then -1 else if a > b then 1 else 0
    )

    ret.pluck('value')

  # Groups the object's values by a criterion. Pass either a string attribute
  # to group by, or a function that returns the criterion.
  groupBy: (iterator) ->
    ret = {}
    @each (args...) =>
      key = iterator(args...)
      value = if @instanceOf(Object) then [args[0], args[1]] else args[0]
      (ret[key] ?= []).push(value)
    return ret

root['Enumerable'] = Enumerable
Enumerable.collect = Enumerable.map
Enumerable.detect = Enumerable.find
