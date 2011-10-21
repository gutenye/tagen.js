String.prototype.toInteger = ->
  parseInt(this)

String.prototype.pluralize = ->
  "#{this}s"

String.prototype.capitalize = ->
  @charAt(0).toUpperCase() + @slice(1)

String.prototype.chop = ->
  if @length == 0 then  "" else @substring(0, @length-1)


String.prototype.endsWith = (str) ->
  @length-str.length == @lastIndexOf(str)


String.prototype.reverse = ->
  s = ""
  i = this.length
  while i > 0 
    s += this.substring(i-1, i)
    i--

  return s

String.prototype.isEmpty = ->
  @length == 0
