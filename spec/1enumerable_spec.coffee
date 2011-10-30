describe 'Enumerable', ->
  # array
  _a = [1, 2]
  # object
  _b = {a: 1, b: 2}

  describe '#any', ->
    it 'any one is true => true', ->
      ret = _a.any (v) ->
        v == 1

      expect(ret).toBeTruthy()

    it 'all false => false', ->
      ret = _a.any (v) ->
        v == -1

      expect(ret).toBeFalsy()

  describe '#all', ->
    it 'all true => true', ->
      ret = _a.all (v) ->
        v == 1 || v == 2

      expect(ret).toBeTruthy()

    it 'one false => false', ->
      ret = _a.all (v) ->
        v == 1

      expect(ret).toBeFalsy()

  describe '#none', ->
    it 'all false => true', ->
      ret = _a.none (v) ->
        v == -1

      expect(ret).toBeTruthy()

    it 'one true => false', ->
      ret = _a.none (v) ->
        v == 1

      expect(ret).toBeFalsy()

  describe '#one', ->
    it 'only one true => true', ->
      ret = _a.one (v) ->
        v == 1

      expect(ret).toBeTruthy()

    it 'more than two true => false', ->
      ret = _a.one (v) ->
        v == 1 || v == 2

      expect(ret).toBeFalsy()
  
    it 'all false => false', ->
      ret = _a.one (v) ->
        v == -1

      expect(ret).toBeFalsy()

  describe '#map', ->
    it 'modify each value and return a new Array', ->
      a = [ 1, 2 ]
      b = [ '1', '2' ]

      ret = _a.map (v) ->
        v.toString()

      expect(ret).toEqual b

    it 'alias as collect', ->
      expect(Array::collect).toBe Array::map


  describe '#find', ->
    it 'find first value is true', ->
      ret = _a.find (v) -> 
        v == 1
      expect(ret).toEqual 1

    it 'retuns null if not found', ->
      ret = _a.find (v) ->
        v == -1

      expect(ret).toBeNull
      
    it 'works for Object', ->
      ret = _b.find (k,v) ->
        v == 1

      expect(ret).toEqual ['a', 1]

    it 'alias as detect', ->
      expect(Array::detect).toBe Array::find

  describe '#findAll', ->
    it 'return all fined values', ->
      a = [ 1, 2, 1, 3, 4 ]
      b = [ 1, 1, 3 ]

      ret = a.findAll (v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

    it 'works for Object', ->
      a = { a: 1, b: 2 , c: 1, d: 3, e: 4 }
      b = [ ['a', 1], ['c', 1], ['d', 3] ]

      ret = a.findAll (k, v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

  describe '#reject', ->
    it 'return all expect rejected values', ->
      a = [ 1, 2, 1, 3, 4 ]
      b = [ 2, 4 ]

      ret = a.reject (v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

    it 'works for Object', ->
      a = { a: 1, b: 2 , c: 1, d: 3, e: 4 }
      b = [ ['b', 2], ['e', 4] ]

      ret = a.reject (k, v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

  describe '#inject', ->
    it 'with initial value', ->
      a = [ 1, 2, 3 ]
      b = 6
      ret = a.inject 0, (memo, v) ->
        memo + v

      expect(ret).toEqual b

    it 'without initial value', ->
      a = [ 1, 2, 3 ]
      b = 6
      ret = a.inject (memo, v) ->
        memo + v

      expect(ret).toEqual b

  describe '#max', ->
    it 'call without argument', ->
      expect(_a.max()).toEqual 2

  describe '#min', ->
    it 'call without arguments', ->
      expect(_a.min()).toEqual 1

  describe '#shuffle', ->
    it 'works', ->
      numbers = ( i for i in [0...100] )
      expect(numbers.shuffle()).not.toEqual numbers

  describe '#sortBy', ->
    it 'works', ->
      a = [ [1, 9], [2, 8] ]
      b = [ [2, 8], [1, 9] ]
      ret = a.sortBy (v, i) ->
        v[1]

      expect(ret).toEqual b

  describe '#groupBy', ->
    it 'works', ->
      a = [ 1, 2, 3, 4 ]
      b = { a: [1, 3], b: [2, 4] }

      ret = a.groupBy (v) ->
        if v == 1 || v == 3 then 'a' else 'b'

      expect(ret).toEqual b
      

    it 'with Object', ->
      a = { a: 1, b: 2, c: 3, d: 4 }
      b = { a: [['a', 1], ['c', 3]], b: [['b', 2], ['d', 4]] }

      ret = a.groupBy (k, v) ->
        if v == 1 || v == 3 then 'a' else 'b'

      expect(ret).toEqual b



  




