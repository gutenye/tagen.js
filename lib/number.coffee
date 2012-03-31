_.reopenClass Number,
  _max: (a, b) -> 
    if a < b then b else a

  _min: (a, b)  ->
    if a > b then b else a

_.reopen Number,

  # times
  #
  #  (3).times (i)->
  #     # ..
  #
  # _times([start=0], callback{i})
  _times: (args...)->
    switch args.length 
      when 2
        [start, callback] = args
      when 1
        [start, callback] = [0, args[0]]

    for i in [0...this]
      callback.call(this, start+i)

  _toInteger: ->
    Math.floor(this)

  # div and Math.floor
  _div: (n)->
    (this / n)._toInteger()

  # div with float
  _fdiv: (n)->
    this / n


