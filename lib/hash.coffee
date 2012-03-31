class Hash extends Object
  constructor: (data)->
    @data = new Object

    if data
      for own k, v of data
        @data[k] = v

  # callback(k, v, self)
  _each: (iterator)->
    try
      for own k, v of @data
        iterator(k, v, @data)
    catch err
      throw err if err != BREAKER

  _isEmpty: ->
    for own k, v of @data
      return false

  _keys: ->
    Object.keys(@data)

  _values: ->
    ret = []
    for k in @keys()
      ret.push @data[k]

    ret

  # default is null
  _fetch: (k, defaultValue) ->
    defaultValue = if defaultValue == undefined then null else defaultValue
    ret = @data[k]
    if ret == undefined then defaultValue else ret

  _store: (k, v) ->
    @data[k] = v

  _fetch_or_store: (k, v) ->
    @data[k] ?= v
    @data[k]

  _toHash: ->
    this

  _toObject: ->
    new Object(@data)

  _keys: () -> 
    keys = []
    @_each (k) ->
      keys.push k
    return keys

  _values: ()->
    @_map (k,v)-> v

  _hasKey: (key)->
    ret = false
    @_each (k) ->
      if k == key
        ret = true 
        throw BREAKER
    ret

  _hasValue: (value)->
    ret = false
    @_each (k,v) ->
      if v == value
        ret = true
        throw BREAKER
    ret


# alias
Hash::_get = Hash::_fetch
Hash::_set = Hash::_store
Hash::_get_or_set = Hash::_fetch_or_store

_.mixin Hash, Enumerable

# convert object to an Hash
H = (data) ->
  new Hash(data)

root['Hash'] = Hash
root['H'] = H
