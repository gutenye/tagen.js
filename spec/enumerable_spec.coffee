describe "Enumerable", ->
  # array
  _a = [1, 2]
  # object
  _b = H(a: 1, b: 2)

  describe "#_any", ->
    it "any one is true => true", ->
      ret = _a._any (v) ->
        v == 1

      expect(ret).toBeTruthy()

    it "all false => false", ->
      ret = _a._any (v) ->
        v == -1

      expect(ret).toBeFalsy()

  describe "#_all", ->
    it "all true => true", ->
      ret = _a._all (v) ->
        v == 1 || v == 2

      expect(ret).toBeTruthy()

    it "one false => false", ->
      ret = _a._all (v) ->
        v == 1

      expect(ret).toBeFalsy()

  describe "#_none", ->
    it "all false => true", ->
      ret = _a._none (v) ->
        v == -1

      expect(ret).toBeTruthy()

    it "one true => false", ->
      ret = _a._none (v) ->
        v == 1

      expect(ret).toBeFalsy()

  describe "#_one", ->
    it "only one true => true", ->
      ret = _a._one (v) ->
        v == 1

      expect(ret).toBeTruthy()

    it "more than two true => false", ->
      ret = _a._one (v) ->
        v == 1 || v == 2

      expect(ret).toBeFalsy()
  
    it "all false => false", ->
      ret = _a._one (v) ->
        v == -1

      expect(ret).toBeFalsy()

  describe "#_map", ->
    it "use native", ->
      a = [ 1, 2 ]
      b = [ "1", "2" ]

      ret = a._map (v) ->
        v.toString()

      expect(ret).toEqual b


  describe "#_find", ->
    it "find first value is true", ->
      ret = _a._find (v) -> 
        v == 1
      expect(ret).toEqual 1

    it "retuns null if not found", ->
      ret = _a._find (v) ->
        v == -1

      expect(ret).toBeNull
      
    it "works for Hash", ->
      ret = _b._find (k,v) ->
        v == 1

      expect(ret).toEqual ["a", 1]

  describe "#_findAll", ->
    it "return all fined values", ->
      a = [ 1, 2, 1, 3, 4 ]
      b = [ 1, 1, 3 ]

      ret = a._findAll (v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

    it "works for Hash", ->
      a = H( a: 1, b: 2 , c: 1, d: 3, e: 4 )
      b = [ ["a", 1], ["c", 1], ["d", 3] ]

      ret = a._findAll (k, v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

  describe "#_reject", ->
    it "return all expect rejected values", ->
      a = [ 1, 2, 1, 3, 4 ]
      b = [ 2, 4 ]

      ret = a._reject (v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

    it "works for Hash", ->
      a = H( a: 1, b: 2 , c: 1, d: 3, e: 4 )
      b = [ ["b", 2], ["e", 4] ]

      ret = a._reject (k, v) ->
        v == 1 || v == 3

      expect(ret).toEqual b

  describe "#_inject", ->
    it "with initial value", ->
      a = [ 1, 2, 3 ]
      b = 6
      ret = a._inject 0, (memo, v) ->
        memo + v

      expect(ret).toEqual b

    it "without initial value", ->
      a = [ 1, 2, 3 ]
      b = 6
      ret = a._inject (memo, v) ->
        memo + v

      expect(ret).toEqual b

  describe "#_max", ->
    it "call without argument", ->
      expect(_a._max()).toEqual 2

  describe "#_min", ->
    it "call without arguments", ->
      expect(_a._min()).toEqual 1

  describe "#_shuffle", ->
    it "works", ->
      numbers = ( i for i in [0...100] )
      expect(numbers._shuffle()).not.toEqual numbers

  describe "#_sortBy", ->
    it "works", ->
      a = [ [1, 9], [2, 8] ]
      b = [ [2, 8], [1, 9] ]
      ret = a._sortBy (v, i) ->
        v[1]

      expect(ret).toEqual b

  describe "#_groupBy", ->
    it "works", ->
      a = [ 1, 2, 3, 4 ]
      b = H( a: [1, 3], b: [2, 4] )

      ret = a._groupBy (v) ->
        if v == 1 || v == 3 then "a" else "b"

      expect(ret).toEqual b
      

    it "with Hash", ->
      a = H( a: 1, b: 2, c: 3, d: 4 )
      b = H( a: [["a", 1], ["c", 3]], b: [["b", 2], ["d", 4]] )

      ret = a._groupBy (k, v) ->
        if v == 1 || v == 3 then "a" else "b"

      expect(ret).toEqual b


  describe "#_eachSlice", ->
    it "works", ->
      a = []
      b = [ [1,2], [3] ]

      [1,2,3]._eachSlice 2, (data)->
        a.push data

      expect(a).toEqual b

  describe "#_eachCons", ->
    it "works", ->
      a = []
      b = [ [1,2], [2,3] ]

      [1,2,3]._eachCons 2, (data)->
        a.push data

      expect(a).toEqual b

    it "n=0", ->
      a = []
      [1,2,3]._eachCons 0, (data)->
        a.push data
      expect(a).toEqual a

    it "n > data.length", ->
      a = []
      [1,2,3]._eachCons 10, (data)->
        a.push data
      expect(a).toEqual a
