Enumerable =
  # any?
  _any: (iterator)->
    ret = false
    @_each (args...)->
      if ret |= iterator(args...)
        return true
    return !!ret

  # all?
  _all: (iterator)->
    ret = true
    @_each (args...)->
      if !iterator(args...)
        ret = false 
        throw BREAKER
    return ret

  # none?
  _none: (iterator)-> 
    ret = true
    @_each (args...)->
      if iterator(args...)
        ret = false
        throw BREAKER
    return ret

  # one?
  _one: (iterator)->
    counts = 0
    @_each (args...)->
      if iterator(args...)
        counts += 1
        throw BREAKER if counts == 2
    return if counts == 1 then true else false

  _map: (iterator) ->
    ret = []
    @_each (args...) => 
      ret.push iterator(args...)
    ret

  _find: (iterator) ->
    ret = null
    @_each (args...) =>
      if iterator(args...)
        ret = if _(@).instanceOf(Hash) then [args[0], args[1]] else args[0]
        throw BREAKER
    return ret

  _findAll: (iterator) ->
    ret = []
    @_each (args...) =>
      if iterator(args...)
        value = if _(@).instanceOf(Hash) then [args[0], args[1]] else args[0]
        ret.push value
    return ret

  # Return all the elements for which a truth test fails.
  # opsite of findAll.
  _reject: (iterator) ->
    ret = []
    @_each (args...) =>
      if !iterator(args...)
        value = if _(@).instanceOf(Hash) then [args[0], args[1]] else args[0]
        ret.push value
    return ret

  # inject(iterator)
  # inject(initial, iterator)
  #
  #  callback{|memo, value| => memo}
  #
  # ONLY Array-like
  #
  _inject: (args...) ->
    switch args.length
      when 1
        initial = null
        iterator = args[0]
      when 2
        initial = args[0]
        iterator = args[1]
      else
        throw "Enumerable#_inject: wrong argument -- #{args}"

    memo = initial
    @_each (value) ->
      if initial == null
        memo = value
        initial = true
      else
        memo = iterator(memo, value)



    memo

  # sum(initial=0[, callback])
  # sum(callback)
  #
  #  callback{|value| => number}
  #
  # ONLY Array-like
  _sum: (args...)->
    switch args.length
      when 1
        if typeof(args[0]) ==  "function"
          initial = 0
          callback = args[0]
        else
          initial = args[0]
          callback = (v) -> v
      when 2
        initial = args[0]
        callback = args[1]
      else
        throw "Enumerable#_sum: wrong argument -- #{args}"

    @_inject initial, (memo, v)->
      memo + callback.call(this, v)

  # Return the maximum element or (element-based computation).
  # ruby: max
  # max()
  # max(iterator)
  #
  # ONLY for Array-like
  #
  # => null, value
  _max: () ->
    if @_isEmpty() 
      return null
    else if _(@).instanceOf(Array)
      return Math.max.apply(Math, this)

  # Return the minimum element (or element-based computation).
  # see max
  _min: (iterator) ->
    if @_isEmpty()
      return null
    else if _(@).instanceOf(Array)
      return Math.min.apply(Math, this)

  # Shuffle an array.
  # only in Array ?
  _shuffle: () ->
    [ shuffled, rand ] = [ [], null ]
    @_each (value, index) ->
      if index == 0
        shuffled[0] = value
      else
        rand = Math.floor(Math.random() * (index + 1))
        shuffled[index] = shuffled[rand]
        shuffled[rand] = value
    return shuffled

  # Sort the object"s values by a criterion produced by an iterator.
  # ONLY Array
  _sortBy: (iterator) ->
    ret = (@_map (args...) ->
      { value: args[0], criteria: iterator(args...) }
    ).sort((a, b) ->
      [ a, b ] = [ a.criteria, b.criteria ]
      if a < b then -1 else if a > b then 1 else 0
    )

    ret._pluck("value")

  # Groups the object"s values by a criterion. Pass either a string attribute
  # to group by, or a function that returns the criterion.
  # @return [Hash]
  _groupBy: (iterator) ->
    ret = H()
    @_each (args...) =>
      key = iterator(args...)
      value = if _(@).instanceOf(Hash) then [args[0], args[1]] else args[0]
      ret._fetch_or_store(key, []).push(value)

    ret

  _eachSlice: (n, callback) ->
    return [] if n==0

    parts = @length._div(n)+1
    end = 0

    parts._times 1, (i)=>
      [start, end] = [end, n*i]
      callback.call(this, @[start...end])

  _eachCons: (n, callback) ->
    return [] if n==0
    start = 0

    loop
      data = @[start...start+n]
      break if data.length < n

      callback.call(this, data)
      start += 1

root["Enumerable"] = Enumerable
Enumerable._collect = Enumerable._map
Enumerable._detect = Enumerable._find
