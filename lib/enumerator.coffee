class Enumerator 
  constructor: (data) ->
    @data = data

  _with_object: (memo, iterator) ->
    @data.each (args...) ->
      iterator(memo, args...)

    memo

  # delegate data.each
  _each: (args...) ->
    @data.each(args...)

root['Enumerator'] = Enumerator
