_.reopenClass Number,
  max: (a, b) -> 
    if a < b then b else a

  min: (a, b)  ->
    if a > b then b else a

_.reopen Number,
  # (3).times (i)->
  #   # ..
  #
  # callback(i)
  times: (fn)->
    for i in [0...this]
      fn(i)
