class Enumerator 
  constructor: (data) ->
    @data = data

  with_object: (memo, iterator) ->
    @data.each (args...) ->
      iterator(memo, args...)

    memo

  # delegate data.each
  each: (args...) ->
    @data.each(args...)

root['Enumerator'] = Enumerator
