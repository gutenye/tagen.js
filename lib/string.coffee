_.reopen String,
  _toInteger: ->
    parseInt(this)

  _pluralize: ->
    "#{this}s"

  _capitalize: ->
    @charAt(0).toUpperCase() + @slice(1)

  _chop: ->
    if @length == 0 then  "" else @substring(0, @length-1)

  _endsWith: (str) ->
    @length-str.length == @lastIndexOf(str)

  _reverse: ->
    s = ""
    i = @length
    while i > 0 
      s += @substring(i-1, i)
      i--

    s

  _isEmpty: ->
    @length == 0
