describe 'Array', ->
  describe '#equals', ->
    it 'works', ->
      expect([1, 2].equals([1, 2])).toBeTruthy()
      expect([1, 2].equals([1, 3])).toBeFalsy()

    it 'with nested array', -> 
      expect([1,[2]].equals([1,[2]])).toBeTruthy()

  describe '#contains', ->
    it 'works', ->
      expect([1,2].contains(2)).toBeTruthy()
      expect([1,2].contains(9)).toBeFalsy()

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
