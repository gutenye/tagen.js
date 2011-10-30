Tagen.mixin Object, Enumerable

# Object's method don't for null, undefined object

Tagen.reopen Object,
  reopen: (attrs)->
    for own k, v of attrs
      Object.defineProperty(this, k, value: v)

  # http://stackoverflow.com/questions/332422/how-do-i-get-the-name-of-an-objects-type-in-javascript
  constructorName: ->
    results = @constructor.toString().match(/function (.{1,})\(/)

    return if results && results.length > 1 then results[1] else ''

  # 1.instanceOf(Number) => true
  instanceOf: (constructorClass)->
    @constructor == constructorClass

  isNaN: ->
    this != this

  # ONLY Object
  # has no enumerable own-properties.
  isEmpty: ->
    for own k, v of this
      return false

  # Invokes interceptor with the obj, and then returns obj.
  # The primary purpose of this method is to "tap into" a method chain, in
  # order to perform operations on intermediate results within the chain.
  tap: (interceptor) ->
    interceptor(this)
    return this

  # Create a (shallow-cloned) duplicate of an object.
  clone: () ->
    ret = {}
    for prop of this
      ret[prop] = this[prop]
    ret

  # Return a sorted list of the function names available on the object.
  methods: () ->
    names = []
    for k, v of this
      names.push(k) if v.instanceOf(Function)
    return names.sort()

  # ONLY Object
  # callback(k, v, self)
  each: (iterator)->
    try
      for own k, v of this
        iterator(k, v, this)
    catch err
      throw err if err != BREAKER

  # ONLY Object
  keys: () -> 
    keys = []
    for own key of this
      keys.push key
    return keys

  # ONLY Object
  values: ()->
    @map (k,v)-> v

  # ONLY Object
  hasKey: (key)->
    for own k of this
      return true if k == key
    return false

  # ONLY Object
  hasValue: (value)->
    for own k, v of this
      return true if v == value
    return false

