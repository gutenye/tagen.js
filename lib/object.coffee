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

  isObject: ->
    return this == new Object(this)

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

