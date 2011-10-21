Array.prototype.equals = (arr) ->
  return false if this.length != arr.length
  for i in [0...this.length]
    if this[i].equals  #likely nested array
      if !this[i].equals(arr[i]) 
        return false 
      else 
        continue
    return false if this[i] != arr[i]
  return true

Array.prototype.contains = (x) ->
  for i in [0...this.length]
    return true if this[i] == x
  
  return false

Array.prototype.random =  ->
  i = Math.random()*@length
  this[Math.floor(i)]

Array.prototype.isEmpty = ->
  @length == 0
