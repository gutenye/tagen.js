Tagen.reopen Object,
  reopen: (attrs)->
    Tagen.reopen(this, attrs)

  # http://stackoverflow.com/questions/332422/how-do-i-get-the-name-of-an-objects-type-in-javascript
  constructorName: ->
    results = @constructor.toString().match(/function (.{1,})\(/)

    return if results && results.length > 1 then results[1] else ''

  # 1.isInstanceOf(Number) => true
  isInstanceOf: (constructorClass)->
    return @constructor == constructorClass

  isNull:  ->
    return this == null

  isUndefined: ->
    return this == undefined

  # Array, String
  # Object: has no enumerable own-properties.
  isEmpty: ->
    switch @constructorName() 
      when 'Array', 'String'
        return @length == 0
      when 'Object'
        for k in this
          return false if hasOwnProperty.call(this, k)
        return true
      else
        throw "not support type. -- #{@constructorName()}"
        ###
