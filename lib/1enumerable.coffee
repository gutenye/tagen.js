root.Enumerable = Enumerable = 
  # any?
  any: (iterator)->
    ret = false
    @each (args...)->
      if ret |= iterator(args...)
        return true
    return !!result

  # all?
  all: (iterator)->
    ret = true
    @each (args...)->
      if !(ret = ret && iterator(args...)) 
        return false 
    return ret

  # none?
  none: (iterator)-> 
    ret = true
    @each (args...)->
      if ret = ret && iterator(args...)
        return false 
    return ret

  # one?
  one: (iterator)->
    counts = 0
    @each (args...)->
      if iterator(args...)
        counts += 1
        return false if counts == 2
    return if counts == 1 then true else false

  map: (iterator) ->
    ret = []
    @each (args...) -> 
      ret.push iterator(args...)
    ret

  # ONLY Array
  pluck: (key) ->
    @map (value) ->
      value[key]

  find: (iterator) ->
    ret = null
    @any (args...) ->
      if iterator(args...)
        ret = if @isObject() then [args[0], args[1]] else args[0]
        return true
    return ret

  findAll: (iterator) ->
    ret = []
    @each (args...) ->
      if iterator(args...)
        value = if @isObject() then [args[0], args[1]] else args[0]
        ret.push value
    return ret


  # Return all the elements for which a truth test fails.
  reject: (iterator) ->
    ret = []
    @each (args...) ->
      if !iterator(args...)
        value = if @isObject() then [args[0], args[1]] else args[0]
        ret.push value
    return ret

  # inject(iterator)
  # inject(initial, iterator)
  #
  #  callback{|memo, args...| => memo}
  #
  inject: (margs...)->
    switch margs.length
      when 1
        initial = null
        iterator = margs[0]
      when 2
        initial = margs[0]
        iterator = margs[1]
      else
        throw 'wrong argument'

    memo = initial
    @each obj, (value, args...)->
      if initial == null
        memo = value
        initial = true
      else
        memo = iterator(memo, args...)

    memo


  # Invoke a method (with arguments) on every item in a collection.
  # only in Array
  invoke: (method, args...) ->
    @map (args2...) ->
      value = args2[0]
      method = if method.call then method || value else value[method]
      method.apply(value, args...)


  # Return the maximum element or (element-based computation).
  # max()
  # max(iterator)
  #
  # ONLY for Array
  #
  # => null, value
  max: (iterator) ->
    if !iterator
      if @isEmpty() 
        return null
      else if @instanceOf(Array)
        return Math.max.apply(Math, this)

    ret = {value: null, computed: -Infinity}
    @each (args...)->
      value = args[0]
      computed = if iterator then iterator(args...) else value
      computed >= ret.computed && (ret = {value: value, computed: computed})
    return ret.value

  # Return the minimum element (or element-based computation).
  min: (iterator) ->
    if !iterator
      if @isEmpty()
        return null
      else if @instanceOf(Array)
        return Math.max.apply(Math, this)

    ret = {value: null, computed: Infinity}
    @each (args...) ->
      value = args[0]
      computed = if iterator then iterator(args...) else value
      computed < ret.computed && (ret = {value : value, computed : computed})
    return ret.value


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

Enumerable.collect = Enumerable.map
Enumerable.detect = Enumerable.find
