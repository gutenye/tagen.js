# Establish the object that gets returned to break out of a loop iteration.
breaker = {}

Ap = Array.prototype

Ap.equals = (arr) ->
  return false if this.length != arr.length
  for i in [0...this.length]
    if this[i].equals  #likely nested array
      if !this[i].equals(arr[i]) 
        return false 
      else 
        continue
    return false if this[i] != arr[i]
  return true

Ap.contains = (x) ->
  for i in [0...this.length]
    return true if this[i] == x
  
  return false

Ap.random =  ->
  i = Math.random()*@length
  this[Math.floor(i)]

Ap.isEmpty = ->
  @length == 0

Ap.each = (iterator, context)->
  if @forEach
    @forEach(iterator, context)
  else
    for i in this
      return if i in obj && iterator.call(context, obj[i], i, obj) == breaker
