Tagen.reopen String,
  toInteger: ->
    parseInt(this)

  pluralize: ->
    "#{this}s"

  capitalize: ->
    @charAt(0).toUpperCase() + @slice(1)

  chop: ->
    if @length == 0 then  "" else @substring(0, @length-1)

  endsWith: (str) ->
    @length-str.length == @lastIndexOf(str)

  reverse: ->
    s = ""
    i = @length
    while i > 0 
      s += @substring(i-1, i)
      i--

    s

  isEmpty: ->
    @length == 0
