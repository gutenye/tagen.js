describe "Array", ->
  describe "#_each", ->
    it "works", ->
      a = [1, 2]
      b = [ [1, 0], [2, 1] ]
      ret = []

      a._each (v,i) ->
        ret.push [v, i]

      expect(ret).toEqual b

    it "return <#Enumerator> when called without any arguments", ->
      a = [1, 2]
      b = a._each()
      expect(b.constructor).toEqual Enumerator
      expect(b.data).toEqual a

    it "break if throw BREAKER", ->
      a = [1, 2, 3]
      b = []
      c = [1]
      a._each (v)->
        throw BREAKER if v == 2
        b.push v

      expect(b).toEqual c

  describe "#_isEqual", ->
    it "works", ->
      expect([1, 2]._isEqual([1, 2])).toBeTruthy()
      expect([1, 2]._isEqual([1, 3])).toBeFalsy()

    it "with nested array", -> 
      expect([1,[2]]._isEqual([1,[2]])).toBeTruthy()

  describe "#_isInclude", ->
    it "works", ->
      expect([1,2]._isInclude(2)).toBeTruthy()
      expect([1,2]._isInclude(9)).toBeFalsy()

    it "alias as _contains", ->
      expect([]._contains).toBe []._isInclude

  describe "#_isEmpty", ->
    it "works", ->
      expect([]._isEmpty()).toBeTruthy()
      expect([1]._isEmpty()).toBeFalsy()

  describe "#_clone", ->
    it "return a shadow-clone", ->
      b = [1]
      a = b._clone()

      expect(a).toEqual b
      expect(a).not.toBe b

  describe "#_random", ->
    it "works", ->
      data = [0, 1]
      counts = {}
      for i in [0..9]
        k = data._random()
        counts[k] ?= 0
        counts[k] += 1

      expect(counts[0]+counts[1]).toEqual 10
      expect(counts[0]).not.toEqual 10

  describe "#_zip", ->
    it "works", ->
      a = [1,2]._zip([3,4])
      b = [ [1,3], [2,4] ]
      expect(a).toEqual b
    
  describe "#_first", ->
    it "return the first element of the array", ->
      expect([1,2]._first()).toEqual 1
    
  describe "#_last", ->
    it "return the last element of the array", ->
      expect([1,2]._last()).toEqual 2

  describe "#_compact", ->
    it "remove all null values", ->
      a = [1, true, null, false, [] ]
      b = [1, true, false, [] ]
      expect(a._compact()).toEqual b

  describe "#_flatten", ->
    it "flatten one-level", ->
      a = [ 1, [2] ]
      b = [ 1, 2 ]
      expect(a._flatten()).toEqual b

    it "flatten multi-levels", ->
      a = [ 1, [2, [3]], ]
      b = [ 1, 2, 3 ]
      c = [ 1, 2, [3] ]
      expect(a._flatten()).toEqual b
      # with shallow=true
      expect(a._flatten(true)).toEqual c

  describe "#_uniq", ->
    it "removes duplicate-values", -> 
      a = [ 1, 3, 2, 1, 3]
      b = [ 1, 3, 2 ]
      expect(a._uniq()).toEqual b

  describe "#_without", ->
    it "Take the difference between one array and another.", ->
      a = [ 1, 2, 3, 4 ]
      b = [ 2, 4 ]
      c = [ 1, 3 ]
      expect(a._without(b...)).toEqual c

  describe "#_pluck", ->
    it "works", ->
      a = [ {a: 1}, {a: 2} ]
      b = [ 1, 2 ]
      expect(a._pluck("a")).toEqual b

  describe "#_findIndex", ->
    it "find with a value", ->
      a = [ 1, 2, 3 ]
      b = 1

      expect(a._findIndex(2)).toEqual b

    it "find with an iterator", ->
      a = [ 1, 2, 3 ]
      b = 1

      ret = a._findIndex (v) ->
        v == 2

      expect(ret).toEqual b

  describe "#_invoke", ->
    it "call each method", ->
      a = [ 1, 2 ]
      b = [ "1", "2" ]

      expect(a._invoke("toString")).toEqual b

  describe "#_transpose", ->
    it "transposes an array", ->
      a = [ [1,2], [3,4] ]
      b = [ [1,3], [2,4] ]

      expect(a._transpose()).toEqual b
