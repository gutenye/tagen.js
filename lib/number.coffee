_.reopenClass Number,
  _max: (a, b) -> 
    if a < b then b else a

  _min: (a, b)  ->
    if a > b then b else a

_.reopen Number,
  # (3).times (i)->
  #   # ..
  #
  # callback(i)
  _times: (fn)->
    for i in [0...this]
      fn(i)
