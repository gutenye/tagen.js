class Hash extends Object
  @_: (attrs)->
    new Hash(attrs)

  constructor: (attrs)->
    @attrs = {}

    for k, v of attrs
      @attrs[k] = v

  keys: ->
    Object.keys(@attrs)

  values: ->
    ret = []
    for k in @keys()
      ret.push @attrs[k]

    ret

  get: (k)->
    @attrs[k]

  set: (k, v)->
    @attrs[k] = v

  toHash: ->
    this

  toObject: ->
    new Object(@attrs)

  toString: ->
    @attrs

h = Hash._(a:1)


#window.Hash = Hash





