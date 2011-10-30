Tagen.mixin Object, Enumerable

Tagen.reopen Object,
  reopen: (attrs)->
    Tagen.reopen(this, attrs)

  # http://stackoverflow.com/questions/332422/how-do-i-get-the-name-of-an-objects-type-in-javascript
  constructorName: ->
    results = @constructor.toString().match(/function (.{1,})\(/)

    return if results && results.length > 1 then results[1] else ''

  # callback(k, v, self)
  each: (iterator)->
    for own k, v of this
      iterator(k, v, this)

  # 1.instanceOf(Number) => true
  instanceOf: (constructorClass)->
    return @constructor == constructorClass

  isNull: ->
    return this == null

  isUndefined: ->
    return this == undefined

  # Object: has no enumerable own-properties.
  isEmpty: ->
    for own k, v of this
      return false

  hasKey: (key)->
    for own k of this
      return true if k == key
    return false

  hasValue: (value)->
    for own k, v of this
      return true if v == value
    return false



  # Invokes interceptor with the obj, and then returns obj.
  # The primary purpose of this method is to "tap into" a method chain, in
  # order to perform operations on intermediate results within the chain.
  tap: (interceptor) ->
    interceptor(this)
    return this

  # Create a (shallow-cloned) duplicate of an object.
  clone: () ->
    @extend({}, this)

  # Return a sorted list of the function names available on the object.
  methods: () ->
    names = []
    for key of obj
      names.push(key) if obj[key].instanceOf(Function)
    return names.sort()

  # ONLY Object
  keys: () -> 
    keys = []
    for own key of this
      keys.push key
    return keys

  # ONLY Object
  values: ()->
    @map (k,v)-> v
