class Hash extends Object
  constructor: (data)->
    @data = new Object

    if data
      for own k, v of data
        @data[k] = v

  # callback(k, v, self)
  each: (iterator)->
    try
      for own k, v of @data
        iterator(k, v, @data)
    catch err
      throw err if err != BREAKER

  isEmpty: ->
    for own k, v of @data
      return false

  keys: ->
    Object.keys(@data)

  values: ->
    ret = []
    for k in @keys()
      ret.push @data[k]

    ret

  # default is null
  fetch: (k, defaultValue) ->
    defaultValue = if defaultValue == undefined then null else defaultValue
    ret = @data[k]
    if ret == undefined then defaultValue else ret

  store: (k, v) ->
    @data[k] = v

  fetch_or_store: (k, v) ->
    @data[k] ?= v
    @data[k]

  toHash: ->
    this

  toObject: ->
    new Object(@data)

  keys: () -> 
    keys = []
    @each (k) ->
      keys.push k
    return keys

  values: ()->
    @map (k,v)-> v

  hasKey: (key)->
    ret = false
    @each (k) ->
      if k == key
        ret = true 
        throw BREAKER
    ret

  hasValue: (value)->
    ret = false
    @each (k,v) ->
      if v == value
        ret = true
        throw BREAKER
    ret


# alias
Hash::get = Hash::fetch
Hash::set = Hash::store
Hash::get_or_set = Hash::fetch_or_store

_.mixin Hash, Enumerable

# convert object to an Hash
H = (data) ->
  new Hash(data)

root['Hash'] = Hash
root['H'] = H
