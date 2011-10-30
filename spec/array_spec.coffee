describe 'Array', ->
  describe '#each', ->
    it 'works', ->
      a = [1, 2]
      b = [ [1, 0], [2, 1] ]
      ret = []

      a.each (v,i) ->
        ret.push [v, i]

      expect(ret).toEqual b

    it 'return <#Enumerator> when called without any arguments', ->
      a = [1, 2]
      b = a.each()
      expect(b.constructor).toEqual Enumerator
      expect(b.data).toEqual a

    it 'break if throw BREAKER', ->
      a = [1, 2, 3]
      b = []
      c = [1]
      a.each (v)->
        throw BREAKER if v == 2
        b.push v

      expect(b).toEqual c

  describe '#isEqual', ->
    it 'works', ->
      expect([1, 2].isEqual([1, 2])).toBeTruthy()
      expect([1, 2].isEqual([1, 3])).toBeFalsy()

    it 'with nested array', -> 
      expect([1,[2]].isEqual([1,[2]])).toBeTruthy()

  describe '#isInclude', ->
    it 'works', ->
      expect([1,2].isInclude(2)).toBeTruthy()
      expect([1,2].isInclude(9)).toBeFalsy()

    it 'alias as contains', ->
      expect([].contains).toBe [].isInclude

  describe '#isEmpty', ->
    it 'works', ->
      expect([].isEmpty()).toBeTruthy()
      expect([1].isEmpty()).toBeFalsy()

  describe '#clone', ->
    it 'return a shadow-clone', ->
      b = [1]
      a = b.clone()

      expect(a).toEqual b
      expect(a).not.toBe b

  describe '#random', ->
    it 'works', ->
      data = [0, 1]
      counts = {}
      for i in [0..9]
        k = data.random()
        counts[k] ?= 0
        counts[k] += 1

      expect(counts[0]+counts[1]).toEqual 10
      expect(counts[0]).not.toEqual 10

  describe '#zip', ->
    it 'works', ->
      a = [1,2].zip([3,4])
      b = [ [1,3], [2,4] ]
      expect(a).toEqual b
    
  describe '#first', ->
    it 'return the first element of the array', ->
      expect([1,2].first()).toEqual 1
    
  describe '#last', ->
    it 'return the last element of the array', ->
      expect([1,2].last()).toEqual 2

  describe '#compact', ->
    it 'remove all null values', ->
      a = [1, true, null, false, [] ]
      b = [1, true, false, [] ]
      expect(a.compact()).toEqual b

  describe '#flatten', ->
    it 'flatten one-level', ->
      a = [ 1, [2] ]
      b = [ 1, 2 ]
      expect(a.flatten()).toEqual b

    it 'flatten multi-levels', ->
      a = [ 1, [2, [3]], ]
      b = [ 1, 2, 3 ]
      c = [ 1, 2, [3] ]
      expect(a.flatten()).toEqual b
      # with shallow=true
      expect(a.flatten(true)).toEqual c

  describe '#uniq', ->
    it 'removes duplicate-values', -> 
      a = [ 1, 3, 2, 1, 3]
      b = [ 1, 3, 2 ]
      expect(a.uniq()).toEqual b

  describe '#without', ->
    it 'Take the difference between one array and another.', ->
      a = [ 1, 2, 3, 4 ]
      b = [ 2, 4 ]
      c = [ 1, 3 ]
      expect(a.without(b...)).toEqual c

  describe '#pluck', ->
    it 'works', ->
      a = [ {a: 1}, {a: 2} ]
      b = [ 1, 2 ]
      expect(a.pluck('a')).toEqual b

  describe '#findIndex', ->
    it 'find with a value', ->
      a = [ 1, 2, 3 ]
      b = 1

      expect(a.findIndex(2)).toEqual b

    it 'find with an iterator', ->
      a = [ 1, 2, 3 ]
      b = 1

      ret = a.findIndex (v) ->
        v == 2

      expect(ret).toEqual b

  describe '#invoke', ->
    it 'call each method', ->
      a = [ 1, 2 ]
      b = [ '1', '2' ]

      expect(a.invoke('toString')).toEqual b

    

